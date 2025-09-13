<?php
/*
 * Template Name: Home Hero Template
 * Description: Page template that renders the custom hero section (hero-section.php).
 */
get_header();

// Hero styles are enqueued via the child theme's functions.php (simple_rt_enqueue_hero_css)
// This avoids printing inline <link> tags in template files and keeps asset loading centralized.

// Include the hero section partial if available
// Debug: directly include the hero partial and emit a marker so we can confirm rendering.
$hero_partial = get_stylesheet_directory() . '/hero-section.php';
if ( file_exists( $hero_partial ) ) {
    echo "<!-- HOME_HERO_TEMPLATE_LOADED -->\n";
    include $hero_partial; // include directly from child theme
} else {
    echo '<p>Hero section template not found at ' . esc_html( $hero_partial ) . '</p>';
}

// Optionally render the loop/content below the hero
?>
<main id="content" role="main">
    <?php
    while ( have_posts() ) : the_post();
        the_content();
    endwhile;
    ?>
</main>

<?php
get_footer();
