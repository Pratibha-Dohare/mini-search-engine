# NovaSearch ✦
Google-inspired mini search engine, built with **HTML, CSS, JavaScript, PHP and MySQL**.

## Features
- Live AJAX search and relevant keyword ranking (title > keywords > description)
- 18 seeded website records (editable in MySQL)
- Responsive design and suggestion chips
- Prepared SQL statements and safe DOM rendering
- No frameworks or build step

## Files
- `index.html` — search page
- `assets/style.css` — styling
- `assets/app.js` — frontend live search via `fetch`
- `search.php` — PHP JSON API
- `db.example.php` — database configuration template
- `database.sql` — sample data
- `.htaccess` — blocks direct access to config and docs on Apache

## Run locally (XAMPP)
1. Unzip into `C:\xampp\htdocs\nova-search`.
2. Start **Apache** and **MySQL** in XAMPP.
3. Open `http://localhost/phpmyadmin`, create database `nova_search`, select it, and import `database.sql`.
4. Copy `db.example.php` to `db.php` (default local settings are root / empty password).
5. Visit `http://localhost/nova-search/` — **not** `file:///.../index.html`.

## Publish source code on GitHub
1. Create a new GitHub repository, e.g. `NovaSearch`.
2. Upload all source files/folders including `.gitignore`, but **never upload `db.php`**.
3. Add screenshots and your deployed URL to this README if desired.
4. GitHub Pages won't run PHP/MySQL. Use InfinityFree below for the live demo.

## Deploy live on InfinityFree
1. Create a free hosting account at https://www.infinityfree.com/ and choose a subdomain.
2. Open your hosting control panel → **MySQL Databases** → create a database.
3. Save the **database hostname, full database name, username, and password** from your hosting dashboard.
4. Open **phpMyAdmin** from that hosting account, select your new database, import `database.sql`.
5. Make a new `db.php` by copying `db.example.php`, and replace all four values with your InfinityFree settings. **MySQL host is not `localhost` on InfinityFree**.
6. Open **File Manager** (or FileZilla FTP), enter the `htdocs` folder of your website.
7. Upload `index.html`, `search.php`, `db.php`, `.htaccess` and the whole `assets` directory **directly inside `htdocs`** (not a nested `nova-search` folder). Do **not** upload `database.sql`, `db.example.php`, or README for the live website.
8. Visit your assigned `https://your-subdomain.../` URL and search for `python`, `AI`, or `design`.

### Troubleshooting
- Blank results / API error: check `search.php?q=python` in your browser, then verify `db.php` credentials and imported SQL data.
- 404: ensure files are directly within `htdocs`.
- Searching doesn't work locally when double-clicking HTML: run through localhost/Apache instead.
- On some host configurations, if `.htaccess` causes a 500 error, check supported directives in your account; **keep `db.php` protected**.
- PHP needs PDO MySQL + mbstring extensions (available on common PHP hosting environments).

**Security:** `db.php` contains secrets. It is ignored by git; keep it out of GitHub. The sample database file is demo-only and contains public URLs.
