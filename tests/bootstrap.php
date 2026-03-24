<?php
/**
 * PHPUnit bootstrap file.
 *
 * Provides lightweight WordPress function stubs so unit tests can run
 * without a full WordPress environment.
 *
 * @package BrideEnvy
 */

require_once dirname( __DIR__ ) . '/vendor/autoload.php';

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', '/tmp/wordpress/' );
}

// WordPress function stubs -- add as needed for tested code paths.
if ( ! function_exists( 'wp_parse_args' ) ) {
	function wp_parse_args( $args, $defaults = array() ) {
		if ( is_string( $args ) ) {
			parse_str( $args, $args );
		}
		return array_merge( $defaults, (array) $args );
	}
}

if ( ! function_exists( 'get_option' ) ) {
	function get_option( $option, $default = false ) {
		return $default;
	}
}

if ( ! function_exists( 'absint' ) ) {
	function absint( $maybeint ) {
		return abs( (int) $maybeint );
	}
}
