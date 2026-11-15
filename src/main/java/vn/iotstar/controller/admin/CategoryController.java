package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, 
                 maxFileSize = 1024 * 1024 * 5, 
                 maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet(urlPatterns = { "/admin/categories", "/admin/category/add", "/admin/category/insert",
        "/admin/category/edit", "/admin/category/update", "/admin/category/delete", "/admin/category/list" })
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/categories") || url.contains("/admin/category/list")) {
            List<Category> list = cateService.findAll();
            req.setAttribute("listcate", list);
            req.setAttribute("cateList", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Category category = cateService.findById(id);
                req.setAttribute("cate", category);
                req.setAttribute("category", category);
            }
            req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/delete")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                try {
                    cateService.delete(id);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        // 1. Chức năng Thêm mới (Insert)
        if (url.contains("/admin/category/insert")) {
            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");
            int status = (statusStr != null) ? Integer.parseInt(statusStr) : 1;
            String images = req.getParameter("images");

            Category category = new Category();
            category.setCategoryname(categoryname);
            category.setStatus(status);

            String fname = "";
            String uploadPath = Constant.DIR + File.separator + "category";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            try {
                Part part = req.getPart("images1");
                if (part == null) {
                    part = req.getPart("icon");
                }
                if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = (index != -1) ? filename.substring(index + 1) : "png";
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + File.separator + fname);
                    category.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    category.setImages(images.trim());
                } else {
                    category.setImages("avatar.png");
                }
            } catch (Exception e) {
                e.printStackTrace();
                category.setImages("avatar.png");
            }

            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }

        // 2. Chức năng Cập nhật (Update)
        if (url.contains("/admin/category/update")) {
            String idStr = req.getParameter("categoryid");
            if (idStr == null || idStr.isEmpty()) {
                idStr = req.getParameter("id");
            }
            int categoryid = Integer.parseInt(idStr);
            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");
            int status = (statusStr != null) ? Integer.parseInt(statusStr) : 1;
            String images = req.getParameter("images");

            Category category = cateService.findById(categoryid);
            if (category != null) {
                String fileold = category.getImages();
                category.setCategoryname(categoryname);
                category.setStatus(status);

                String fname = "";
                String uploadPath = Constant.DIR + File.separator + "category";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                try {
                    Part part = req.getPart("images1");
                    if (part == null) {
                        part = req.getPart("icon");
                    }
                    if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                        // Xóa file cũ nếu không phải link http/https
                        if (fileold != null && !fileold.startsWith("http")) {
                            deleteFile(uploadPath + File.separator + fileold);
                        }
                        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                        int index = filename.lastIndexOf(".");
                        String ext = (index != -1) ? filename.substring(index + 1) : "png";
                        fname = System.currentTimeMillis() + "." + ext;
                        part.write(uploadPath + File.separator + fname);
                        category.setImages(fname);
                    } else if (images != null && !images.trim().isEmpty()) {
                        category.setImages(images.trim());
                    } else {
                        category.setImages(fileold);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                cateService.update(category);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    public static void deleteFile(String filePath) {
        try {
            Path path = Paths.get(filePath);
            Files.deleteIfExists(path);
        } catch (Exception ignored) {
        }
    }
}
