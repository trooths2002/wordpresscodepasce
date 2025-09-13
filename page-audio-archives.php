<?php
/**
 * Template Name: Audio Archives
 *
 * This page template displays a hero header for the Audio Archives page
 * and renders the page content. You can populate the page with audio
 * posts or embed individual audio players via shortcodes. The design
 * ensures accessibility and search engine optimization by using proper
 * heading structure and semantic markup.
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

  <main class="sub-main" id="main" role="main">
    <?php the_content(); ?>
  </main>
  <?php
endwhile;

get_footer();