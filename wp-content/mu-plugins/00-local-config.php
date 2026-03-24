<?php
/**
 * Local development configuration overrides.
 *
 * Only active when LOCAL_DEV environment variable is set (Docker).
 * Safe to deploy -- does nothing on staging/production.
 *
 * @package BrideEnvy
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

if ( getenv( 'LOCAL_DEV' ) ) {
	// Route all WordPress emails through Mailhog.
	add_action(
		'phpmailer_init',
		function ( $phpmailer ) {
			$phpmailer->isSMTP();
			// phpcs:ignore WordPress.NamingConventions.ValidVariableName.UsedPropertyNotSnakeCase -- PHPMailer property names.
			$phpmailer->Host = 'mailhog';
			// phpcs:ignore WordPress.NamingConventions.ValidVariableName.UsedPropertyNotSnakeCase -- PHPMailer property names.
			$phpmailer->Port = 1025;
			// phpcs:ignore WordPress.NamingConventions.ValidVariableName.UsedPropertyNotSnakeCase -- PHPMailer property names.
			$phpmailer->SMTPAuth = false;
		}
	);
}
