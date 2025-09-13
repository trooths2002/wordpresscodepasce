<?php
// Usage: wp eval-file set_elementor_display_condition.php --path=/var/www/html --allow-root --post_id=29436
$post_id = isset( $argv ) && isset( $argv[1] ) ? intval( $argv[1] ) : ( isset( $_SERVER['argv'][1] ) ? intval( $_SERVER['argv'][1] ) : 0 );
if ( ! $post_id ) {
    // Try reading from environment variable
    if ( defined( 'WP_CLI' ) ) {
        // If called via wp cli with --post_id=ID, WP-CLI passes it differently; we will try to parse
        foreach ( $_SERVER['argv'] as $arg ) {
            if ( strpos( $arg, '--post_id=' ) === 0 ) {
                $post_id = intval( substr( $arg, strlen( '--post_id=' ) ) );
            }
        }
    }
}
if ( ! $post_id ) {
    echo "Please pass the template post ID as --post_id=ID\n";
    return;
}

if ( ! class_exists( '\Elementor\Plugin' ) ) {
    echo "Elementor plugin not loaded; ensure it's active.\n";
    return;
}

// Prepare condition: display on "front_page" (home)
try {
    $conditions_manager = \Elementor\Plugin::instance()->conditions_manager;
    if ( ! $conditions_manager ) {
        echo "Elementor conditions manager not available in this version.\n";
        return;
    }

    // Build a condition for location 'single' or 'front_page' depending on API
    $conditions = array(
        array(
            'location' => 'front_page',
            'conditions' => array(),
        ),
    );

    // Use the conditions manager to save conditions for this template
    if ( method_exists( $conditions_manager, 'save_conditions' ) ) {
        $result = $conditions_manager->save_conditions( $post_id, $conditions );
        echo "save_conditions result: "; var_export( $result ); echo "\n";
    } else {
        // Fallback: store a meta key _elementor_conditions with serialized conditions
        update_post_meta( $post_id, '_elementor_conditions', $conditions );
        echo "Stored fallback _elementor_conditions meta.\n";
    }
} catch ( Exception $e ) {
    echo "Exception while setting conditions: " . $e->getMessage() . "\n";
}
