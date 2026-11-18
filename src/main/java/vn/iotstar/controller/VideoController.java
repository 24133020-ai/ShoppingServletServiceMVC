package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.impl.VideoServiceImpl;
import vn.iotstar.util.Constant;

/**
 * CRUD Video của user đang đăng nhập, danh sách phân trang 6 video / trang tại /video,
 * xem chi tiết và play video tại /video/detail. Upload poster bằng @MultipartConfig.
 */
@SuppressWarnings("serial")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
                 maxFileSize = 1024 * 1024 * 5,
                 maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet(urlPatterns = { "/video", "/video/add", "/video/insert", "/video/edit", "/video/update",
        "/video/delete", "/video/detail" })
public class VideoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public IVideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User user = currentUser(req);
        String path = req.getServletPath();

        if (path.equals("/video")) {
            // Danh sách video của user, phân trang
            int total = videoService.countByUser(user.getId());
            int totalPages = Math.max(1, (int) Math.ceil((double) total / Constant.VIDEO_PAGE_SIZE));
            int page = parsePage(req.getParameter("page"), totalPages);
            List<Video> list = videoService.findByUser(user.getId(), page - 1, Constant.VIDEO_PAGE_SIZE);

            req.setAttribute("listvideo", list);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            if ("toolarge".equals(req.getParameter("msg"))) {
                req.setAttribute("alert", "File poster quá lớn (tối đa 5MB).");
            }
            req.getRequestDispatcher(Constant.Path.VIDEO_LIST).forward(req, resp);

        } else if (path.equals("/video/add")) {
            req.getRequestDispatcher(Constant.Path.VIDEO_ADD).forward(req, resp);

        } else if (path.equals("/video/edit")) {
            Video video = findOwnVideo(req, user);
            if (video == null) {
                resp.sendRedirect(req.getContextPath() + "/video");
                return;
            }
            req.setAttribute("video", video);
            req.getRequestDispatcher(Constant.Path.VIDEO_EDIT).forward(req, resp);

        } else if (path.equals("/video/delete")) {
            Video video = findOwnVideo(req, user);
            if (video != null) {
                videoService.delete(video.getVideoId());
            }
            resp.sendRedirect(req.getContextPath() + "/video");

        } else if (path.equals("/video/detail")) {
            // Xem chi tiết và play video (mọi user đăng nhập đều xem được)
            String id = req.getParameter("id");
            Video video = (id == null) ? null : videoService.findById(id);
            if (video == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            req.setAttribute("video", video);
            req.getRequestDispatcher(Constant.Path.VIDEO_DETAIL).forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // Đọc form multipart; vượt quá giới hạn của @MultipartConfig sẽ ném IllegalStateException
        try {
            req.getParts();
        } catch (IllegalStateException e) {
            resp.sendRedirect(req.getContextPath() + "/video?msg=toolarge");
            return;
        }

        User user = currentUser(req);
        String path = req.getServletPath();

        // 1. Thêm mới (Insert)
        if (path.equals("/video/insert")) {
            String videoId = trim(req.getParameter("videoId"));
            String title = trim(req.getParameter("title"));

            Video video = new Video();
            video.setVideoId(videoId);
            video.setTitle(title);
            video.setDescription(req.getParameter("description"));
            video.setActive("1".equals(req.getParameter("active")));
            video.setUser(user);

            String error = null;
            if (videoId.isEmpty() || title.isEmpty()) {
                error = "Vui lòng nhập Video ID và Title.";
            } else if (!videoId.matches("[A-Za-z0-9_-]{1,50}")) {
                error = "Video ID chỉ gồm chữ, số, dấu - và _ (tối đa 50 ký tự).";
            } else if (videoService.findById(videoId) != null) {
                error = "Video ID đã tồn tại!";
            }
            if (error == null) {
                try {
                    video.setPoster(savePoster(req, null));
                } catch (IllegalArgumentException e) {
                    error = e.getMessage();
                }
            }
            if (error != null) {
                req.setAttribute("alert", error);
                req.setAttribute("video", video);
                req.getRequestDispatcher(Constant.Path.VIDEO_ADD).forward(req, resp);
                return;
            }

            videoService.insert(video);
            resp.sendRedirect(req.getContextPath() + "/video");
            return;
        }

        // 2. Cập nhật (Update)
        if (path.equals("/video/update")) {
            Video video = findOwnVideo(req, user, req.getParameter("videoId"));
            if (video == null) {
                resp.sendRedirect(req.getContextPath() + "/video");
                return;
            }
            String title = trim(req.getParameter("title"));
            String oldPoster = video.getPoster();

            video.setTitle(title);
            video.setDescription(req.getParameter("description"));
            video.setActive("1".equals(req.getParameter("active")));

            String error = title.isEmpty() ? "Vui lòng nhập Title." : null;
            if (error == null) {
                try {
                    video.setPoster(savePoster(req, oldPoster));
                } catch (IllegalArgumentException e) {
                    error = e.getMessage();
                }
            }
            if (error != null) {
                video.setPoster(oldPoster);
                req.setAttribute("alert", error);
                req.setAttribute("video", video);
                req.getRequestDispatcher(Constant.Path.VIDEO_EDIT).forward(req, resp);
                return;
            }

            videoService.update(video);
            resp.sendRedirect(req.getContextPath() + "/video");
        }
    }

    private String savePoster(HttpServletRequest req, String oldPoster) throws IOException, ServletException {
        Part part = req.getPart("posterFile");
        if (part == null || part.getSize() == 0 || part.getSubmittedFileName() == null
                || part.getSubmittedFileName().trim().isEmpty()) {
            return oldPoster;
        }
        if (part.getContentType() == null || !part.getContentType().startsWith("image/")) {
            throw new IllegalArgumentException("Poster phải là file ảnh.");
        }

        String uploadPath = Constant.DIR + File.separator + "video";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        int index = filename.lastIndexOf(".");
        String ext = (index != -1) ? filename.substring(index + 1) : "png";
        String fname = System.currentTimeMillis() + "." + ext;
        part.write(uploadPath + File.separator + fname);

        if (oldPoster != null && !oldPoster.isEmpty()) {
            deleteFile(uploadPath + File.separator + oldPoster);
        }
        return fname;
    }

    public static void deleteFile(String filePath) {
        try {
            Files.deleteIfExists(Paths.get(filePath));
        } catch (Exception ignored) {
        }
    }

    private User currentUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session == null ? null : (User) session.getAttribute("account");
    }

    private Video findOwnVideo(HttpServletRequest req, User user) {
        return findOwnVideo(req, user, req.getParameter("id"));
    }

    /** Chỉ trả về video nếu thuộc về user đang đăng nhập. */
    private Video findOwnVideo(HttpServletRequest req, User user, String id) {
        if (id == null || id.trim().isEmpty()) {
            return null;
        }
        Video video = videoService.findById(id.trim());
        if (video == null || video.getUser() == null || video.getUser().getId() != user.getId()) {
            return null;
        }
        return video;
    }

    private int parsePage(String value, int totalPages) {
        int page = 1;
        try {
            page = Integer.parseInt(value);
        } catch (NumberFormatException ignored) {
        }
        return Math.min(Math.max(page, 1), totalPages);
    }

    private String trim(String s) {
        return s == null ? "" : s.trim();
    }
}
