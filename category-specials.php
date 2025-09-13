<?php
/**
 * Category template for the "Specials" category.
 *
 * This template mirrors the design of the Messages in Black archive but can
 * be customized further if desired. It showcases posts in a grid format
 * with a hero header derived from the category metadata.
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