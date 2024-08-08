<div align="center" style="display: flex; align-items: center; justify-content: center;">
  <img src="https://ahmettarikdemirci.io/todolist/screen_shoots/logo.png" alt="Logo" style="height: 200px; margin-right: 10px;">

</div>



ToDoListApp, kullanıcıların yapılacaklar listelerini (to-do list) yönetmelerine olanak tanır. Kullanıcılar hesaplarını yönetebilir, kategoriler oluşturabilir ve görevler ekleyebilir, güncelleyebilir ve silebilirler. Uygulama, JWT tabanlı kimlik doğrulama kullanarak güvenliği sağlar.

## Özellikler

- Kullanıcı kaydı ve girişi
- Kullanıcı adı, şifre ve e-posta güncelleme
- Hesap silme
- Kategori oluşturma, güncelleme ve silme
- Görev (todo) ekleme, güncelleme ve silme
- Görevlerin tamamlanma durumlarını güncelleme

## Gereksinimler
• iOS 17.0+
 
## Proje Kararları ve Yapısı

•	Alamofire: Ağ isteklerini yönetmek için kullanıldı. RESTful API ile iletişim kurmak için ideal.
•	JWT: JSON Web Token kullanarak kullanıcı kimlik doğrulaması sağlandı.
•	iOS 17.0+: Swift dilinin en son özelliklerini ve performans iyileştirmelerini kullanmak için gerekli.
•	Backend: PHP ile yazıldı ve MySQL veritabanı kullanıldı.
•	Sunucu: Hostinger üzerinde barındırılıyor. phpMyAdmin ile veritabanı yönetimi yapılıyor.
 
### Ekran Görüntüleri 

<div style="display: flex; overflow-x: auto;">
  <img src="https://ahmettarikdemirci.io/todolist/screen_shoots/login.png" alt="Giriş Ekranı" style="height: 300px; margin-right: 10px;">
  <img src="https://ahmettarikdemirci.io/todolist/screen_shoots/register.png" alt="Kayıt Ekranı" style="height: 300px; margin-right: 10px;">
  <img src="https://ahmettarikdemirci.io/todolist/screen_shoots/todo.png" alt="Ana Ekran" style="height: 300px; margin-right: 10px;">
  <img src="https://ahmettarikdemirci.io/todolist/screen_shoots/donetodo.png" alt="Kategori Yönetimi" style="height: 300px; margin-right: 10px;">
  <img src="https://ahmettarikdemirci.io/todolist/screen_shoots/settings.png" alt="Görev Yönetimi" style="height: 300px; margin-right: 10px;">
 
</div>

## Kullanım Videosu

<div align="center">

https://github.com/user-attachments/assets/3c8e989a-69f5-46ef-b0eb-a4056af4ecc8

</div>

## Backend
1.	Sunucu Kurulumu:
	•	Projeyi barındırmak için Hostinger üzerinde bir sunucu satın aldım.
	•	Sunucuda PHP 7.4+ ve MySQL 5.7+ kurulu olmalıdır.
2.	Veritabanı Kurulumu:
	•	MySQL veritabanı oluşturun ve aşağıdaki tabloları phpMyAdmin kullanarak oluşturun:
```
 CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    date_of_registration TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    category_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE todos (
    id VARCHAR(36) PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    due_date TIMESTAMP NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_done BOOLEAN NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);
```
3.	PHP Dosyalarını Sunucuya Yükleyin:
	•	Projenin php klasöründe bulunan dosyaları sunucuya yükleyin.
4.	API URL’lerini Ayarlayın:
	•	iOS projesinde API URL’lerini kendi sunucu URL’inize göre ayarlayın.

## Postman'de API'yi Test Etmek İçin
Projemizin API'lerini Postman ile kolayca test edebilirsiniz. Aşağıdaki butona tıklayarak Postman koleksiyonunuza ekleyebilirsiniz.

API dökümantasyonu için [Postman Dokümantasyonu](./TodoList.md) dosyasına bakabilirsiniz.

[![Run in Postman](https://run.pstmn.io/button.svg)](https://solar-meteor-116601.postman.co/workspace/My-Workspace~7b9dc3c3-c830-4a6a-88f8-75ea302d8c2e/folder/37255916-4b1a0090-fe70-40c5-84e2-d1fb1f935240?action=share&creator=37255916&ctx=documentation)

## Dokümantasyon

Proje dokümantasyonuna erişmek için aşağıdaki butona tıklayabilirsiniz.

[![Dokümantasyon](https://img.shields.io/badge/API%20Docs-Open-green)](https://ahmettarikdemirci.io/todolist/docs/index.html)

## Katkıda Bulunma
Katkıda bulunmak isterseniz, lütfen bir pull request gönderin. Her türlü katkı için teşekkür ederiz!

<h3 align="center">Benimle iletişime geçin:</h3>
<p align="center">
<a href="mailto:ahmettarikdemirci@icloud.com" target="blank"><img align="center" src="https://ahmettarikdemirci.io/todolist/screen_shoots/mail.png" alt="ahmettarikdemirci@gmail.com" height="40" width="40" /></a>
<a href="https://linkedin.com/in/ahmet-tar%c4%b1k-demirci" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="ahmet-tar%c4%b1k-demirci" height="30" width="40" /></a>
<a href="https://instagram.com/ahmettarikdemirci" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/instagram.svg" alt="ahmettarikdemirci" height="30" width="40" /></a>
<a href="https://www.youtube.com/@user-tm8ri2tk9c" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/youtube.svg" alt="@user-tm8ri2tk9c" height="30" width="40" /></a>
</p>

<br/>  

<div align="center">
            <a href="https://www.buymeacoffee.com/ahmettarikdemirci" target="_blank" style="display: inline-block;">
                <img
                    src="https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-orange.svg?style=flat-square&logo=buymeacoffee" 
                    align="center"
                />
            </a></div>
<br />
