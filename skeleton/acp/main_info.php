<?php
/**
 *
 * test. An extension for the phpBB Forum Software package.
 *
 * @copyright (c) 2019, test
 * @license GNU General Public License, version 2 (GPL-2.0)
 *
 */

namespace test\test\acp;

/**
 * test ACP module info.
 */
class main_info
{
	public function module()
	{
		return array(
			'filename'	=> '\test\test\acp\main_module',
			'title'		=> 'ACP_TEST_TITLE',
			'modes'		=> array(
				'settings'	=> array(
					'title'	=> 'ACP_TEST',
					'auth'	=> 'ext_test/test && acl_a_board',
					'cat'	=> array('ACP_TEST_TITLE')
				),
			),
		);
	}
}
