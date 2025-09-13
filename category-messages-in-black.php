<?php
/**
 * Category template for the "Messages in Black" category.
 *
 * This template displays a custom hero section using the category name
 * and description, followed by a grid layout for posts. It is optimized
 * for readability and SEO with proper heading structure and accessible
 * markup. To use this template, create a category with the slug
 * "messages-in-black" and WordPress will automatically load it.
 */

get_header();

$category = get_queried_object();
?>

<section class="sub-hero">
  <div class="sub-hero__overlay"></div>
  <div class="sub-hero__content">
    <h1 class="sub-title"><?php echo esc_html( $category->name ); ?></h1>
    <?php if ( ! empty( $category->description ) ) : ?>
      <p class="sub-tagline"><?php echo esc_html( $category->description ); ?></p>
    <?php endif; ?>
  </div>
</section>

<main class="sub-main" id="main" role="main">
  <?php if ( have_posts() ) : ?>
    <div class="posts-grid">
      <?php
      // Start the Loop.
      while ( have_posts() ) :
        the_post();
        ?>
        <article <?php post_class( 'post-card' ); ?>>
          <?php if ( has_post_thumbnail() ) : ?>
            <a href="<?php the_permalink(); ?>" class="post-thumbnail" aria-hidden="true" tabindex="-1">
              <?php the_post_thumbnail( 'medium', [ 'alt' => get_the_title() ] ); ?>
            </a>
          <?php endif; ?>
          <h2 class="post-title"><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h2>
          <div class="post-excerpt">
            <?php the_excerpt(); ?>
          </div>
          <a class="read-more" href="<?php the_permalink(); ?>"><?php esc_html_e( 'Read More', 'rt' ); ?></a>
        </article>
      <?php endwhile; ?>
    </div>
    <?php the_posts_pagination(); ?>
  <?php else : ?>
    <p><?php esc_html_e( 'No articles found in this category.', 'rt' ); ?></p>
  <?php endif; ?>
</main>

<?php
get_footer();