<?php
/**
 * Template Name: About
 *
 * This page template provides a hero section and a flexible content area
 * for the About page. Use it to tell the story of your organisation,
 * highlight your mission, and share historical context. Proper heading
 * structure ensures good SEO and accessibility.
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

  <main class="sub-main about-main" id="main" role="main">
    <?php the_content(); ?>
  </main>
  <?php
endwhile;

get_footer();