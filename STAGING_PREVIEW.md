# Staging Preview Checklist

This checklist describes the steps to preview and validate the staging site after the hero template and other theme updates were applied.

## Access
- URL: `http://localhost/` (or the host/port the container maps to, e.g. `http://localhost:8080/`).
- WP Admin: `http://localhost/wp-admin/` (use admin credentials available in your environment).

## Quick smoke tests (desktop)
- [ ] Open homepage and confirm hero section visible.
  - View source and confirm `hero.css` link exists: `/wp-content/themes/simple-theme-child/hero.css`.
  - Confirm the DOM contains `<section class="rt-hero">`.
- [ ] Check homepage at different widths (desktop/tablet/mobile) using browser devtools.
- [ ] Confirm header and footer render correctly.
- [ ] Visit a sample subpage and confirm site styles are intact.

## Admin checks
- [ ] WP Admin -> Settings -> Reading: `Your homepage displays` should be set to `A static page` and `Homepage` set to the Home page (ID 29435).
- [ ] WP Admin -> Pages -> Open Home (ID 29435) and check `Page Attributes` -> `Template` shows `Home Hero Template`.
- [ ] WP Admin -> Plugins: confirm whether Elementor is active (if active, check Theme Builder for front-page templates).

## Debug cleanup
- [ ] Remove or archive `wp-content/mu-plugins/log_template.php` (archived and committed in this branch).
- [ ] Confirm `/var/www/html/wp-content/template-log.txt` (if present) is removed or archived.

## Performance / Assets
- [ ] Check Network tab in browser devtools for any 404s on CSS/JS (notably `hero.css` and Elementor assets).
- [ ] Confirm hero image assets load (e.g., `universe-background.jpg`).

## Mobile & Accessibility
- [ ] Confirm the hero heading is readable at small widths, adequate contrast, and accessible elements use `aria` attributes as needed.

## Screenshots & Approval
- [ ] Capture desktop and mobile screenshots of the homepage and attach to PR for review.
- [ ] Once approved, schedule a deployment to production with a DB and file backup.

---

Notes:
- This branch `staging/cleanup-hero-debug` contains the theme changes and archived debug files. Open PR: `https://github.com/trooths2002/wordpresscodepasce/pull/new/staging/cleanup-hero-debug`.
- If you want the hero to be managed by Elementor instead of the theme, I recommend importing via Elementor UI to avoid malformed postmeta.
