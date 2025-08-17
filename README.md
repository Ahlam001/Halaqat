# نظرة عامة
هذا المشروع عبارة عن نظام لإدارة وبحث الحلقات (CMS + Discovery) يتيح:
- رفع الحلقات من YouTube أو رفع فيديوهات مباشرة إلى Amazon S3.
- إدارة الحلقات، تصنيفها، وتعيين مالك لكل حلقة.
- البحث والتصفية حسب العنوان، التصنيف، أو المحرر.
- عرض الحلقات للجمهور من خلال واجهة اكتشاف (Discovery).
- دعم تعدد الأدوار للمحررين (Editor, رئيس المحررين، إلخ).

التقنيات المستخدمة
 – إطار العمل الأساسيRuby on Rails 7 .
 - قاعدة البيانات الرئيسية PostgreSQL
 - تخزين ملفات الفيديو والصور Amazon S3
 - تصميم واجهة المستخدم Tailwind CSS
 -  تقسيم النتائج Pagination Kaminari
 -  إدارة تسجيل الدخول للمحررين Devise
 

الإعداد والتشغيل محليًا
المتطلبات:
لغة Ruby 3.2.2، PostgreSQL 14+ ، Yarn أو npm


حساب AWS S3 (مع مفاتيح)

#خطوات التشغيل


#### تثبيت الباقات >  > bundle install
#### تهيئة قاعدة البيانات >  rails db:setup
#### تشغيل الخادم > bin/rails server

بيانات تسجيل الدخول التجريبية
البريد: editor@example.com
كلمة المرور: password123

ميزات الأمان
تشفير بيانات AWS S3 في Rails Credentials.
استخدام .gitignore لحماية أي ملفات حساسة.

جميع عمليات البحث باستخدام Scopes لمنع SQL Injection.
التحكم في الصلاحيات حسب الدور (Role-based access).

https://github.com/user-attachments/assets/12e0fe33-8e51-4959-8a3a-a9446ec3730e



https://github.com/user-attachments/assets/25ddfcda-94b0-41e1-836c-356f4af6c531


https://github.com/user-attachments/assets/3e17745d-dd7a-4962-a557-4091b128bad3



https://github.com/user-attachments/assets/4f8fa344-4b02-4af9-a48d-f1254ad8f424



