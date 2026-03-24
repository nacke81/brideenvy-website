<?php
/**
 * Smoke test to verify PHPUnit is working.
 *
 * @package BrideEnvy
 */

use Yoast\PHPUnitPolyfills\TestCases\TestCase;

/**
 * Basic smoke test.
 */
class SmokeTest extends TestCase {

	/**
	 * Verify the test suite runs.
	 */
	public function test_true_is_true() {
		$this->assertTrue( true );
	}
}
