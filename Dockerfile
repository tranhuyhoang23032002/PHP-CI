# Sử dụng image PHP chính thức, có cài sẵn Apache
FROM php:7.4-apache

# Cài các extension cần thiết cho PHP nếu có
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copy code của bạn vào thư mục chứa website
COPY . /var/www/html/

# Phân quyền cho thư mục chứa ứng dụng
RUN chown -R www-data:www-data /var/www/html/

# Expose cổng 80 để ứng dụng có thể truy cập qua HTTP
EXPOSE 80

# Bắt đầu dịch vụ Apache khi container khởi chạy
CMD ["apache2-foreground"]
