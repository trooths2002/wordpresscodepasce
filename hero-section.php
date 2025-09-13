<?php
/*
 * Hero section template for The Righteous Teachers.
 *
 * This snippet can be included in a child theme or template part to render
 * the custom hero section on the homepage. It uses dynamic functions
 * from WordPress to ensure links and titles remain up to date. The
 * portrait image should be stored in the child theme’s `images` directory
 * as `elijah-muhammad.png`. The background image can be set via
 * CSS (`background-image` property) in an accompanying stylesheet.
 */
?>
<section class="rt-hero">
  <div class="rt-hero__overlay"></div>
  <header class="rt-hero__nav">
    <a class="rt-logo" href="<?php echo esc_url( home_url( '/' ) ); ?>">
      <?php bloginfo( 'name' ); ?>
    </a>
    <nav aria-label="Primary">
      <?php
        wp_nav_menu( [
          'theme_location' => 'primary',
          'container'      => false,
          'menu_class'     => 'rt-menu',
          'fallback_cb'    => false,
        ] );
      ?>
    </nav>
  </header>
  <div class="rt-hero__content">
    <h1 class="rt-title"><?php echo esc_html( get_bloginfo( 'name' ) ); ?></h1>
    <p class="rt-tagline">
      <?php
      // Replace this with your preferred tagline or retrieve from site description.
      echo esc_html__( 'The rewards of research is to find the facts that verify the truth.', 'rt' );
      ?>
    </p>
    <div class="rt-cta">
      <?php
      $about_page   = get_page_by_path( 'about' );
      $contact_page = get_page_by_path( 'contact' );
      ?>
      <?php if ( $about_page ) : ?>
        <a class="rt-btn" href="<?php echo esc_url( get_permalink( $about_page ) ); ?>">
          <?php esc_html_e( 'Learn More', 'rt' ); ?>
        </a>
      <?php endif; ?>
      <?php if ( $contact_page ) : ?>
        <a class="rt-btn rt-btn--ghost" href="<?php echo esc_url( get_permalink( $contact_page ) ); ?>">
          <?php esc_html_e( 'Get Started', 'rt' ); ?>
        </a>
      <?php endif; ?>
    </div>
  </div>
  <?php
  /**
   * Note: The portrait of the Honorable Elijah Muhammad is baked into the
   * universe background artwork. We intentionally omit a separate portrait
   * element here to ensure that the text remains accessible and the layout
   * scales smoothly on all devices. If you prefer to include a separate
   * portrait image, you can reintroduce an <img> element here and define
   * corresponding styles in hero.css.
   */
  ?>
</section>