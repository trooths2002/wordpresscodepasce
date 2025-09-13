<?php
/**
 * Template Name: Contact
 *
 * This page template renders a hero section and the content of your
 * Contact page. It works well with contact form plugins such as
 * Forminator or Contact Form 7. Add your form shortcode within the
 * page content from the WordPress editor.
 */

get_header();

while ( have_posts() ) :
  the_post();
  ?>
  <section class="sub-hero">
    <div class="sub-hero__overlay"></div>
    <div class="sub-hero__content">
      <h1 class="sub-title"><?php the_title(); ?></h1>
      <?php if ( has_excerpt() ) : ?>
        <p class="sub-tagline"><?php echo esc_html( get_the_excerpt() ); ?></p>
      <?php endif; ?>
    </div>
  </section>

  <main class="sub-main contact-main" id="main" role="main">
    <?php the_content(); ?>
  </main>
  <?php
endwhile;

get_footer();