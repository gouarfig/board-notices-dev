<?php
/**
 *
 * test. An extension for the phpBB Forum Software package.
 *
 * @copyright (c) 2019, test
 * @license GNU General Public License, version 2 (GPL-2.0)
 *
 */

namespace test\test\migrations;

class install_cron extends \phpbb\db\migration\migration
{
	public function effectively_installed()
	{
		return isset($this->config['test_cron_last_run']);
	}

	public static function depends_on()
	{
		return array('\phpbb\db\migration\data\v31x\v314');
	}

	public function update_data()
	{
		return array(
			array('config.add', array('test_cron_last_run', 0)),
		);
	}
}
