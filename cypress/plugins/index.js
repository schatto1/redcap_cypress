// ***********************************************************
// This example plugins/index.js can be used to load plugins
//
// You can change the location of this file or turn off loading
// the plugins file with the 'pluginsFile' configuration option.
//
// You can read more here:
// https://on.cypress.io/plugins-guide
// ***********************************************************

// This function is called when a project is opened or re-opened (e.g. due to
// the project's config changing)

module.exports = (on, config) => {
  // `on` is used to hook into various events Cypress emits
  // `config` is the resolved Cypress config

  on('task', {

  	populateStructureAndData({redcap_version, advanced_user_info, source_location}) {

  		var shell = require('shelljs');

		// DEFINE OTHER LOCATIONS
		var test_seeds_location = process.env.PWD + '/test_db';
		var seeds_location = test_seeds_location + '/seeds';

		var db_prefix_sql = test_seeds_location + '/structure_prefix.sql';
		var sql_path = source_location + '/redcap_v' + redcap_version + '/Resources/sql';
		var install_sql = sql_path + '/install.sql';
		var data_sql = sql_path + '/install_data.sql';

		if(advanced_user_info === "true"){
			var user_sql = seeds_location + '/user_info/advanced.sql';
		} else {
			var user_sql=`${seeds_location}/user_info/standard.sql`
		}

		var auth_sql = seeds_location + '/auth.sql';
		var rights_sql = seeds_location + '/rights.sql';
		var config_sql = seeds_location + '/config.sql';
		var projects_sql = seeds_location + '/projects.sql';

		//CREATE STRUCTURE FILE
		var structure_and_data_file = test_seeds_location + '/structure_and_data.sql';

		//REMOVE EXISTING STRUCTURE AND DATA FILE
		shell.rm(structure_and_data_file);

		//CREATE NEW STRUCTURE AND DATA FILE FROM REDCAP SOURCE
		shell.cat(db_prefix_sql).to(structure_and_data_file);
		shell.cat(install_sql).toEnd(structure_and_data_file);
		shell.cat(data_sql).toEnd(structure_and_data_file);

		shell.cat(user_sql).toEnd(structure_and_data_file);
		shell.cat(auth_sql).toEnd(structure_and_data_file);
		shell.cat(rights_sql).toEnd(structure_and_data_file);


		//DEMO PROJECT SEEDS
		for(i = 1; i<=12; i++){
			let demo_sql=`${sql_path}/create_demo_db${i}.sql`
			shell.cat(demo_sql).toEnd(structure_and_data_file)
		}

		shell.cat(projects_sql).toEnd(structure_and_data_file);
		shell.cat(config_sql).sed('REDCAP_VERSION_MAGIC_STRING', redcap_version).toEnd(structure_and_data_file);

		shell.echo('\nCOMMIT;').toEnd(structure_and_data_file);

		return 0;
  	}  	

  })  	

}