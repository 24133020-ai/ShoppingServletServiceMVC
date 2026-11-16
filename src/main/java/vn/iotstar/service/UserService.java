package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface UserService {

    /** Kết quả của các thao tác gửi / xác thực OTP. */
    enum OtpResult {
        OK,                 // thành công
        NOT_FOUND,          // không có tài khoản phù hợp
        INVALID,            // mã OTP sai
        EXPIRED,            // mã OTP hết hạn
        TOO_MANY_ATTEMPTS,  // nhập sai quá số lần cho phép
        TOO_SOON,           // yêu cầu gửi lại quá nhanh
        MAIL_ERROR          // gửi email thất bại
    }

    /** Đăng nhập: trả về User nếu username + mật khẩu đúng (kể cả chưa kích hoạt), ngược lại null. */
    User login(String username, String password);

    User get(String username);
    User getByEmail(String email);
    void insert(User user);

    /** Tạo tài khoản MỚI ở trạng thái chưa kích hoạt, mật khẩu được băm. Trả về null nếu username đã tồn tại. */
    User register(String username, String password, String email, String fullname, String phone);

    /** Sinh OTP mới, lưu DB và gửi email. purpose = ACTIVATE hoặc RESET. */
    OtpResult sendOtp(String email, String purpose);

    /** Xác thực OTP kích hoạt và kích hoạt tài khoản. */
    OtpResult activateAccount(String email, String otp);

    /** Xác thực OTP quên mật khẩu và đặt mật khẩu mới (đã băm). */
    OtpResult resetPassword(String email, String otp, String newPassword);

    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
}
