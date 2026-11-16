package vn.iotstar.controller;

import java.io.IOException;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.UserService.OtpResult;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    private static final Pattern EMAIL = Pattern.compile("^[\\w.+-]+@[\\w-]+(\\.[\\w-]+)+$");
    private UserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }
        req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()
                || email == null || email.trim().isEmpty() || fullname == null || fullname.trim().isEmpty()) {
            fail(req, resp, "Vui lòng nhập đầy đủ thông tin!");
            return;
        }
        username = username.trim();
        email = email.trim().toLowerCase();

        if (!EMAIL.matcher(email).matches()) {
            fail(req, resp, "Email không hợp lệ!");
            return;
        }
        if (password.length() < Constant.PASSWORD_MIN_LENGTH) {
            fail(req, resp, "Mật khẩu phải có ít nhất " + Constant.PASSWORD_MIN_LENGTH + " ký tự!");
            return;
        }
        if (service.checkExistEmail(email)) {
            fail(req, resp, "Email đã tồn tại! Nếu bạn chưa kích hoạt, hãy đăng nhập để nhận lại mã OTP.");
            return;
        }
        if (service.checkExistUsername(username)) {
            fail(req, resp, "Tài khoản đã tồn tại!");
            return;
        }

        User user = service.register(username, password, email, fullname.trim(), phone == null ? null : phone.trim());
        if (user == null) {
            fail(req, resp, "System error!");
            return;
        }

        // Gửi OTP kích hoạt tới email rồi chuyển sang trang nhập OTP
        OtpResult r = service.sendOtp(email, Constant.PURPOSE_ACTIVATE);
        req.getSession(true).setAttribute(Constant.SESSION_OTP_EMAIL, email);
        resp.sendRedirect(req.getContextPath() + "/verify-otp?msg=" + (r == OtpResult.OK ? "sent" : "mailerror"));
    }

    private void fail(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("alert", message);
        req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
    }
}
