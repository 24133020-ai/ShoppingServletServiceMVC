# Shopping Servlet Service MVC

## 1. Giới thiệu
Website quản lý cửa hàng được xây dựng
bằng Java Servlet, JSP và mô hình MVC.

## 2. Chức năng
- Đăng ký tài khoản, **kích hoạt tài khoản bằng mã OTP gửi qua email**
- Đăng nhập với **mật khẩu được mã hóa (PBKDF2-HMAC-SHA256 + salt)** và đăng xuất
- **Quên mật khẩu**: nhận mã OTP qua email để đặt lại mật khẩu
- Phân quyền người dùng (AuthFilter chặn truy cập khi chưa đăng nhập / sai quyền)
- Quản lý video: thêm, sửa, xóa video của user (bảng `videos` quan hệ 1-N với `User`), upload poster bằng Multipart
- Trang chủ `/home` hiển thị 10 video mới nhất
- Trang `/video` hiển thị tất cả video của user, phân trang 6 video / trang
- Xem chi tiết và play video khi bấm vào tiêu đề (`/video/detail?id=...`)
- Quản lý danh mục sản phẩm
- Thêm, sửa, xóa và xem danh sách danh mục
- Upload hình ảnh danh mục
- Dùng SiteMesh 3.3.0 với một Bootstrap 3.4.1 decorator dùng chung cho các trang HTML
- Validation phía trình duyệt và phía Servlet cho Login, Register, Forgot Password, Insert và Edit (danh mục/video)

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
1. Cài đặt JDK 22, Maven và Tomcat 11 (ứng dụng đang dùng Jakarta Servlet 6.1).
2. Mở dự án bằng IntelliJ IDEA hoặc Eclipse.
3. Chạy `database.sql` trong SQL Server Management Studio (script tạo/cập nhật các bảng `User`, `categories`, `videos`).
4. Thiết lập biến môi trường cho cửa sổ PowerShell sẽ chạy Tomcat:

   ```powershell
   $env:DB_USER = "tai_khoan_sql_server"
   $env:DB_PASSWORD = "mat_khau_sql_server"
   # Nếu SQL Server dùng instance/port khác, có thể cấu hình thêm:
   # $env:DB_URL = "jdbc:sqlserver://localhost:1433;encrypt=true;trustServerCertificate=true;databaseName=ShoppingServiceMVC"
   ```

5. Cấu hình gửi email (xem mục 5). Nếu chưa cấu hình MAIL_USERNAME/MAIL_PASSWORD, OTP được in trong console Tomcat để kiểm thử ở chế độ DEV.
6. Chạy lệnh:

   mvn clean package

7. Deploy file WAR trong thư mục `target` lên Apache Tomcat 11.

## 5. Cấu hình gửi email
Khuyến nghị dùng biến môi trường `MAIL_USERNAME` và `MAIL_PASSWORD` (Google App Password):

```powershell
$env:MAIL_USERNAME = "gmail_gui_otp@gmail.com"
$env:MAIL_PASSWORD = "google_app_password"
```

Có thể cấu hình thêm `MAIL_HOST` và `MAIL_PORT`; mặc định là `smtp.gmail.com:587`.
Không commit App Password hoặc file `mail.properties` lên GitHub. File cấu hình mẫu là `mail.properties.example`.

Nếu chưa cấu hình, ứng dụng chạy chế độ DEV: mã OTP được in ra console của Tomcat
(dòng bắt đầu bằng `[MAIL][DEV]`) thay vì gửi email thật.

## 6. SiteMesh và validation
- Maven dependency: `org.sitemesh:sitemesh:3.3.0`.
- SiteMesh 3 được đăng ký trong `WEB-INF/web.xml` bằng `ConfigurableSiteMeshFilter`.
- Cấu hình mapping nằm tại `WEB-INF/sitemesh3.xml`.
- Bootstrap decorator dùng chung nằm tại `WEB-INF/decorators/bootstrap.html`.
- Các form kiểm tra dữ liệu ở cả HTML5 và Servlet trước khi gọi Service/DAO.
- Các form CRUD danh mục và video kiểm tra độ dài, định dạng mã/tên và loại file ảnh; giới hạn upload ảnh là 5MB.

## 7. Truy cập website
http://localhost:8080/ShoppingServletServiceMVC/login

## 8. Tài khoản thử nghiệm
Tài khoản để  test danh mục sản phẩm: admin
Mật khẩu: 123456

Tài khoản này cũng là admin nhưng dùng tên khác: viethuan
Mật khẩu: 123456

Tài khoản user để kiểm tra về phần video: hi
Mật khẩu: 123456

(Mật khẩu trong database đã được băm, các tài khoản mới đăng ký phải kích hoạt bằng OTP.)
