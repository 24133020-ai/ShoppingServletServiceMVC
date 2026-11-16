# Shopping Servlet Service MVC

## 1. Giới thiệu
Website quản lý cửa hàng được xây dựng
bằng Java Servlet, JSP và mô hình MVC.

## 2. Chức năng
- Đăng ký tài khoản, **kích hoạt tài khoản bằng mã OTP gửi qua email**
- Đăng nhập với **mật khẩu được mã hóa (PBKDF2-HMAC-SHA256 + salt)** và đăng xuất
- **Quên mật khẩu**: nhận mã OTP qua email để đặt lại mật khẩu
- Phân quyền người dùng (AuthFilter chặn truy cập khi chưa đăng nhập / sai quyền)
- Quản lý danh mục sản phẩm
- Thêm, sửa, xóa và xem danh sách danh mục
- Upload hình ảnh danh mục

## 3. Luồng OTP
| Chức năng | URL | Mô tả |
|---|---|---|
| Đăng ký | `/register` | Tạo tài khoản ở trạng thái **chưa kích hoạt**, gửi OTP 6 số tới email |
| Kích hoạt | `/verify-otp` | Nhập OTP để kích hoạt; có nút "Gửi lại mã" |
| Đăng nhập | `/login` | Chỉ tài khoản đã kích hoạt mới vào được. Nếu chưa kích hoạt sẽ tự gửi lại OTP |
| Quên mật khẩu | `/forgot-password` | Nhập email để nhận OTP |
| Đặt lại mật khẩu | `/reset-password` | Nhập OTP + mật khẩu mới |
| Đăng xuất | `/logout` | Hủy session, xóa cookie "Nhớ tôi" |

Quy tắc OTP: 6 chữ số, hiệu lực 5 phút, sai tối đa 5 lần, gửi lại cách nhau tối thiểu 60 giây
(chỉnh trong `vn.iotstar.util.Constant`).

## 4. Cấu hình và chạy dự án
1. Cài đặt JDK 22, Maven và Tomcat 10.1.
2. Mở dự án bằng IntelliJ IDEA hoặc Eclipse.
3. Cấu hình kết nối SQL Server (`persistence.xml`) và chạy `database.sql`
   (script tự thêm các cột `active`, `otp*` cho bảng `User` cũ).
4. Cấu hình gửi email (xem mục 5).
5. Chạy lệnh:

   mvn clean package

6. Deploy file WAR trong thư mục target
   lên Apache Tomcat.

## 5. Cấu hình gửi email
Copy `src/main/resources/mail.properties.example` thành `src/main/resources/mail.properties`
rồi điền tài khoản SMTP (Gmail cần bật xác minh 2 bước và tạo **App password**).
Hoặc dùng biến môi trường `MAIL_USERNAME`, `MAIL_PASSWORD` (ưu tiên hơn file).
File `mail.properties` đã được thêm vào `.gitignore`, **không commit lên GitHub**.

Ở đây em không thể up địa chỉ mail với app password thật lên được vì sẽ bị các vấn đề về bảo mật cũng như bị lộ có thể bị kẻ xấu lợi dụng để spam mail rác dẫn đến khóa tài khoản, mong thầy thông cảm cho em ạ.

Em xin cam đoan rằng các yêu cầu được thầy đặt ra đều có thể hoạt động được bình thường, khi thầy chấm điểm có thể yêu cầu em up file lên để chạy thử chương trình ạ, em cảm ơn thầy rất nhiều.

Nếu chưa cấu hình, ứng dụng chạy chế độ DEV: mã OTP được in ra console của Tomcat
(dòng bắt đầu bằng `[MAIL][DEV]`) thay vì gửi email thật.

## 6. Truy cập website
http://localhost:8080/ShoppingServletServiceMVC/login

## 7. Tài khoản thử nghiệm
Tài khoản: admin
Mật khẩu: 123456

Tài khoản: viethuan
Mật khẩu: 123456

(Mật khẩu trong database đã được băm, các tài khoản mới đăng ký phải kích hoạt bằng OTP.)
