<?php
// WP-CLI import script: create an Elementor template (elementor_library) and set required meta safely.
// Usage: wp eval-file import_elementor_hero.php --path=/var/www/html --allow-root

if ( php_sapi_name() !== 'cli' ) {
    echo "This script is intended to be run via WP-CLI.\n";
    return;
}

// Target post title and slug
$title = 'Hero — Programmatic Import';
$slug = 'hero-programmatic-import';

// Load the JSON payload included in workspace file
$json_file = __DIR__ . '/elementor_hero.json';
if ( ! file_exists( $json_file ) ) {
    echo "elementor_hero.json not found in workspace.\n";
    return;
}
$elementor_data = json_decode( file_get_contents( $json_file ), true );
if ( json_last_error() !== JSON_ERROR_NONE ) {
    echo "Invalid JSON in elementor_hero.json: " . json_last_error_msg() . "\n";
    return;
}

// Create the elementor_library post
$postarr = array(
    'post_title'   => $title,
    'post_name'    => $slug,
    'post_status'  => 'publish',
    'post_type'    => 'elementor_library',
);
$post_id = wp_insert_post( $postarr );
if ( is_wp_error( $post_id ) ) {
    echo "Failed to create elementor_library post: " . $post_id->get_error_message() . "\n";
    return;
}

echo "Created elementor_library post id: $post_id\n";

// Backup existing meta if any
$backup = array();
$meta_keys = array( '_elementor_data', '_elementor_page_settings', '_elementor_template_type', '_elementor_edit_mode', '_elementor_css' );
foreach ( $meta_keys as $key ) {
    $val = get_post_meta( $post_id, $key, true );
    if ( ! empty( $val ) ) {
        $backup[ $key ] = $val;
    }
}
if ( ! empty( $backup ) ) {
    file_put_contents( WP_CONTENT_DIR . '/backup_elementor_meta_' . $post_id . '.json', wp_json_encode( $backup, JSON_PRETTY_PRINT ) );
    echo "Backed up existing postmeta to backup_elementor_meta_{$post_id}.json\n";
}

// Properly set _elementor_data as JSON string (Elementor expects JSON stored as string in postmeta)
update_post_meta( $post_id, '_elementor_data', wp_json_encode( $elementor_data ) );

// Set safe page settings as array and store as serialized data
$page_settings = array(
    'elementor_css_print_method' => 'external',
    'settings' => array(),
);
update_post_meta( $post_id, '_elementor_page_settings', $page_settings );

// Template type: use 'section' because the payload is a section
update_post_meta( $post_id, '_elementor_template_type', 'section' );
update_post_meta( $post_id, '_elementor_edit_mode', 'builder' );

// Empty CSS placeholder
update_post_meta( $post_id, '_elementor_css', '' );

// Ensure Elementor regenerates CSS files for the new template
if ( function_exists( '\Elementor\Plugin::instance' ) ) {
    try {
        $elementor = \Elementor\Plugin::instance();
        if ( method_exists( $elementor->files_manager, 'clear_cache' ) ) {
            $elementor->files_manager->clear_cache();
        }
    } catch ( Exception $e ) {
        // Non-fatal
    }
}

echo "Elementor template meta written for post $post_id\n";

// Optionally: create a display condition. Programmatically adding Elementor display conditions is complex and version-specific.
// We'll instead rely on mapping the template by assigning it in Elementor Theme Builder manually or by setting the home page to use this template via theme if desired.

echo "IMPORTANT: Display conditions not set programmatically by this script. Please open Elementor > Templates > Theme Builder and assign this template to the front page, or tell the script to set conditions (advanced).\n";

return;
