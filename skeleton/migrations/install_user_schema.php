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

class install_user_schema extends \phpbb\db\migration\migration
{
	public function effectively_installed()
	{
		return $this->db_tools->sql_column_exists($this->table_prefix . 'users', 'user_test');
	}

	public static function depends_on()
	{
		return array('\phpbb\db\migration\data\v31x\v314');
	}

	public function update_schema()
	{
		return array(
			'add_tables'		=> array(
				$this->table_prefix . 'test_test_table'	=> array(
					'COLUMNS'		=> array(
						'test_id'			=> array('UINT', null, 'auto_increment'),
						'test_name'			=> array('VCHAR:255', ''),
					),
					'PRIMARY_KEY'	=> 'test_id',
				),
			),
			'add_columns'	=> array(
				$this->table_prefix . 'users'			=> array(
					'user_test'				=> array('UINT', 0),
				),
			),
		);
	}

	public function revert_schema()
	{
		return array(
			'drop_columns'	=> array(
				$this->table_prefix . 'users'			=> array(
					'user_test',
				),
			),
			'drop_tables'		=> array(
				$this->table_prefix . 'test_test_table',
			),
		);
	}
}
