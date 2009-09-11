<?php

/*
	Phoronix Test Suite
	URLs: http://www.phoronix.com, http://www.phoronix-test-suite.com/
	Copyright (C) 2008 - 2009, Phoronix Media
	Copyright (C) 2008 - 2009, Michael Larabel
	pts-functions_config.php: Functions needed to read/write to the PTS user-configuration files.

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

function pts_config_init()
{
	pts_user_config_init();
	pts_graph_config_init();
}
function pts_user_config_init($new_config_values = null)
{
	// Validate the config files, update them (or write them) if needed, and other configuration file tasks

	$read_config = new pts_config_tandem_XmlReader($new_config_values);

	if(IS_PTS_LIVE)
	{
		$symlink_default = "TRUE";
		$remove_downloaded_files = "TRUE";
	}
	else
	{
		$symlink_default = "FALSE";
		$remove_downloaded_files = "FALSE";
	}

	$config = new tandem_XmlWriter();
	$config->setXslBinding("xsl/pts-user-config-viewer.xsl");
	$config->addXmlObject(P_OPTION_GLOBAL_USERNAME, 0, pts_read_user_config(P_OPTION_GLOBAL_USERNAME, "Default User", $read_config));
	$config->addXmlObject(P_OPTION_GLOBAL_UPLOADKEY, 0, pts_read_user_config(P_OPTION_GLOBAL_UPLOADKEY, "", $read_config));

	$config->addXmlObject(P_OPTION_USAGE_REPORTING, 2, pts_read_user_config(P_OPTION_USAGE_REPORTING, "UNKNOWN", $read_config));
	$config->addXmlObject(P_OPTION_LOAD_MODULES, 2, pts_read_user_config(P_OPTION_LOAD_MODULES, "", $read_config));
	$config->addXmlObject(P_OPTION_DEFAULT_BROWSER, 2, pts_read_user_config(P_OPTION_DEFAULT_BROWSER, "", $read_config));
	$config->addXmlObject(P_OPTION_PHODEVI_CACHE, 2, pts_read_user_config(P_OPTION_PHODEVI_CACHE, "TRUE", $read_config));
	$config->addXmlObject(P_OPTION_DISPLAY_MODE, 2, pts_read_user_config(P_OPTION_DISPLAY_MODE, "DEFAULT", $read_config));

	$config->addXmlObject(P_OPTION_TEST_REMOVEDOWNLOADS, 3, pts_read_user_config(P_OPTION_TEST_REMOVEDOWNLOADS, $remove_downloaded_files, $read_config));
	$config->addXmlObject(P_OPTION_CACHE_SEARCHMEDIA, 3, pts_read_user_config(P_OPTION_CACHE_SEARCHMEDIA, "TRUE", $read_config));
	$config->addXmlObject(P_OPTION_CACHE_SYMLINK, 3, pts_read_user_config(P_OPTION_CACHE_SYMLINK, $symlink_default, $read_config));
	$config->addXmlObject(P_OPTION_PROMPT_DOWNLOADLOC, 3, pts_read_user_config(P_OPTION_PROMPT_DOWNLOADLOC, "FALSE", $read_config));
	$config->addXmlObject(P_OPTION_TEST_ENVIRONMENT, 3, pts_read_user_config(P_OPTION_TEST_ENVIRONMENT, "~/.phoronix-test-suite/installed-tests/", $read_config));
	$config->addXmlObject(P_OPTION_CACHE_DIRECTORY, 3, pts_read_user_config(P_OPTION_CACHE_DIRECTORY, "~/.phoronix-test-suite/download-cache/", $read_config));

	$config->addXmlObject(P_OPTION_TEST_SLEEPTIME, 4, pts_read_user_config(P_OPTION_TEST_SLEEPTIME, "8", $read_config));
	$config->addXmlObject(P_OPTION_LOG_VSYSDETAILS, 4, pts_read_user_config(P_OPTION_LOG_VSYSDETAILS, "FALSE", $read_config));
	$config->addXmlObject(P_OPTION_LOG_BENCHMARKFILES, 4, pts_read_user_config(P_OPTION_LOG_BENCHMARKFILES, "FALSE", $read_config));
	$config->addXmlObject(P_OPTION_RESULTS_DIRECTORY, 4, pts_read_user_config(P_OPTION_RESULTS_DIRECTORY, "~/.phoronix-test-suite/test-results/", $read_config));

	$config->addXmlObject(P_OPTION_BATCH_SAVERESULTS, 5, pts_read_user_config(P_OPTION_BATCH_SAVERESULTS, "TRUE", $read_config));
	$config->addXmlObject(P_OPTION_BATCH_LAUNCHBROWSER, 5, pts_read_user_config(P_OPTION_BATCH_LAUNCHBROWSER, "FALSE", $read_config));
	$config->addXmlObject(P_OPTION_BATCH_UPLOADRESULTS, 5, pts_read_user_config(P_OPTION_BATCH_UPLOADRESULTS, "TRUE", $read_config));
	$config->addXmlObject(P_OPTION_BATCH_PROMPTIDENTIFIER, 5, pts_read_user_config(P_OPTION_BATCH_PROMPTIDENTIFIER, "TRUE", $read_config));
	$config->addXmlObject(P_OPTION_BATCH_PROMPTDESCRIPTION, 5, pts_read_user_config(P_OPTION_BATCH_PROMPTDESCRIPTION, "TRUE", $read_config));
	$config->addXmlObject(P_OPTION_BATCH_PROMPTSAVENAME, 5, pts_read_user_config(P_OPTION_BATCH_PROMPTSAVENAME, "TRUE", $read_config));
	$config->addXmlObject(P_OPTION_BATCH_TESTALLOPTIONS, 5, pts_read_user_config(P_OPTION_BATCH_TESTALLOPTIONS, "TRUE", $read_config));
	$config->addXmlObject(P_OPTION_BATCH_CONFIGURED, 5, pts_read_user_config(P_OPTION_BATCH_CONFIGURED, "FALSE", $read_config));

	file_put_contents(PTS_USER_DIR . "user-config.xml", $config->getXML());

	pts_mkdir(PTS_USER_DIR . "xsl/");
	pts_copy(STATIC_DIR . "pts-user-config-viewer.xsl", PTS_USER_DIR . "xsl/" . "pts-user-config-viewer.xsl");
	pts_copy(STATIC_DIR . "pts-308x160.png", PTS_USER_DIR . "xsl/" . "pts-logo.png");
}
function pts_module_config_init($SetOptions = null)
{
	// Validate the config files, update them (or write them) if needed, and other configuration file tasks

	if(is_file(PTS_USER_DIR . "modules-config.xml"))
	{
		$file = file_get_contents(PTS_USER_DIR . "modules-config.xml");
	}
	else
	{
		$file = "";
	}

	$module_config_parser = new tandem_XmlReader($file);
	$option_module = $module_config_parser->getXMLArrayValues(P_MODULE_OPTION_NAME);
	$option_identifier = $module_config_parser->getXMLArrayValues(P_MODULE_OPTION_IDENTIFIER);
	$option_value = $module_config_parser->getXMLArrayValues(P_MODULE_OPTION_VALUE);

	if(is_array($SetOptions) && count($SetOptions) > 0)
	{
		foreach($SetOptions as $this_option_set => $this_option_value)
		{
			$replaced = false;
			$this_option_set = explode("__", $this_option_set);
			$this_option_module = $this_option_set[0];
			$this_option_identifier = $this_option_set[1];

			for($i = 0; $i < count($option_module) && !$replaced; $i++)
			{
				if($option_module[$i] == $this_option_module && $option_identifier[$i] == $this_option_identifier)
				{
					$option_value[$i] = $this_option_value;
					$replaced = true;
				}
			}

			if(!$replaced)
			{
				array_push($option_module, $this_option_module);
				array_push($option_identifier, $this_option_identifier);
				array_push($option_value, $this_option_value);
			}
		}
	}

	$config = new tandem_XmlWriter();

	for($i = 0; $i < count($option_module); $i++)
	{
		if(pts_module_type($option_module[$i]) != "")
		{
			$config->addXmlObject(P_MODULE_OPTION_NAME, $i, $option_module[$i]);
			$config->addXmlObject(P_MODULE_OPTION_IDENTIFIER, $i, $option_identifier[$i]);
			$config->addXmlObject(P_MODULE_OPTION_VALUE, $i, $option_value[$i]);
		}
	}

	file_put_contents(PTS_USER_DIR . "modules-config.xml", $config->getXML());
}
function pts_config_bool_to_string($bool)
{
	return $bool ? "TRUE" : "FALSE";
}
function pts_graph_config_init($new_config_values = "")
{
	// Initialize the graph configuration file

	$read_config = new pts_graph_config_tandem_XmlReader($new_config_values);
	$config = new tandem_XmlWriter();

	// General
	$config->addXmlObject(P_GRAPH_SIZE_WIDTH, 1, pts_read_graph_config(P_GRAPH_SIZE_WIDTH, "580", $read_config));
	$config->addXmlObject(P_GRAPH_SIZE_HEIGHT, 1, pts_read_graph_config(P_GRAPH_SIZE_HEIGHT, "300", $read_config));
	$config->addXmlObject(P_GRAPH_RENDERER, 1, pts_read_graph_config(P_GRAPH_RENDERER, "PNG", $read_config));
	$config->addXmlObject(P_GRAPH_MARKCOUNT, 1, pts_read_graph_config(P_GRAPH_MARKCOUNT, "6", $read_config));
	$config->addXmlObject(P_GRAPH_WATERMARK, 1, pts_read_graph_config(P_GRAPH_WATERMARK, "PHORONIX-TEST-SUITE.COM", $read_config));
	$config->addXmlObject(P_GRAPH_BORDER, 1, pts_read_graph_config(P_GRAPH_BORDER, "FALSE", $read_config));

	// Colors
	$config->addXmlObject(P_GRAPH_COLOR_BACKGROUND, 2, pts_read_graph_config(P_GRAPH_COLOR_BACKGROUND, "#FFFFFF", $read_config));
	$config->addXmlObject(P_GRAPH_COLOR_BODY, 2, pts_read_graph_config(P_GRAPH_COLOR_BODY, "#8B8F7C", $read_config));
	$config->addXmlObject(P_GRAPH_COLOR_NOTCHES, 2, pts_read_graph_config(P_GRAPH_COLOR_NOTCHES, "#000000", $read_config));
	$config->addXmlObject(P_GRAPH_COLOR_BORDER, 2, pts_read_graph_config(P_GRAPH_COLOR_BORDER, "#FFFFFF", $read_config));
	$config->addXmlObject(P_GRAPH_COLOR_ALTERNATE, 2, pts_read_graph_config(P_GRAPH_COLOR_ALTERNATE, "#B0B59E", $read_config));
	$config->addXmlObject(P_GRAPH_COLOR_PAINT, 2, pts_read_graph_config(P_GRAPH_COLOR_PAINT, "#3B433A, #BB2413, #FF9933, #006C00, #5028CA, #B30000, #A8BC00, #00F6FF, #8A00AC, #790066, #797766, #5598b1", $read_config));

	// Text Colors
	$config->addXmlObject(P_GRAPH_COLOR_HEADERS, 2, pts_read_graph_config(P_GRAPH_COLOR_HEADERS, "#2b6b29", $read_config));
	$config->addXmlObject(P_GRAPH_COLOR_MAINHEADERS, 2, pts_read_graph_config(P_GRAPH_COLOR_MAINHEADERS, "#2b6b29", $read_config));
	$config->addXmlObject(P_GRAPH_COLOR_TEXT, 2, pts_read_graph_config(P_GRAPH_COLOR_TEXT, "#000000", $read_config));
	$config->addXmlObject(P_GRAPH_COLOR_BODYTEXT, 2, pts_read_graph_config(P_GRAPH_COLOR_BODYTEXT, "#FFFFFF", $read_config));

	// Text Size
	$config->addXmlObject(P_GRAPH_FONT_TYPE, 3, pts_read_graph_config(P_GRAPH_FONT_TYPE, "", $read_config));
	$config->addXmlObject(P_GRAPH_FONT_SIZE_HEADERS, 3, pts_read_graph_config(P_GRAPH_FONT_SIZE_HEADERS, "18", $read_config));
	$config->addXmlObject(P_GRAPH_FONT_SIZE_SUBHEADERS, 3, pts_read_graph_config(P_GRAPH_FONT_SIZE_SUBHEADERS, "12", $read_config));
	$config->addXmlObject(P_GRAPH_FONT_SIZE_TEXT, 3, pts_read_graph_config(P_GRAPH_FONT_SIZE_TEXT, "12", $read_config));
	$config->addXmlObject(P_GRAPH_FONT_SIZE_IDENTIFIERS, 3, pts_read_graph_config(P_GRAPH_FONT_SIZE_IDENTIFIERS, "11", $read_config));
	$config->addXmlObject(P_GRAPH_FONT_SIZE_AXIS, 3, pts_read_graph_config(P_GRAPH_FONT_SIZE_AXIS, "11", $read_config));

	file_put_contents(PTS_USER_DIR . "graph-config.xml", $config->getXML());
}
function pts_read_user_config($xml_pointer, $value = null, $tandem_xml = null)
{
	// Read an option from a user's config file
	return pts_read_config("user-config.xml", $xml_pointer, $value, $tandem_xml);
}
function pts_read_graph_config($xml_pointer, $value = null, $tandem_xml = null)
{
	// Read an option from a user's graph config file
	return pts_read_config("graph-config.xml", $xml_pointer, $value, $tandem_xml);
}
function pts_read_config($config_file, $xml_pointer, $value, $tandem_xml)
{
	// Generic call for reading a config file
	if(!($tandem_xml instanceOf tandem_XmlReader))
	{
		if($config_file == "graph-config.xml")
		{
			$tandem_xml = new pts_graph_config_tandem_XmlReader();
		}
		else
		{
			$tandem_xml = new pts_config_tandem_XmlReader();
		}
	}
	
	$temp_value = $tandem_xml->getXmlValue($xml_pointer);

	if(!empty($temp_value))
	{
		$value = $temp_value;
	}

	return $value;
}
function pts_find_home($path)
{
	// Find home directory if needed
	if(strpos($path, "~/") !== false)
	{
		$home_path = pts_user_home();
		$path = str_replace("~/", $home_path, $path);
	}

	return pts_add_trailing_slash($path);
}
function pts_user_home()
{
	// Gets the system user's home directory
	if(function_exists("posix_getpwuid") && function_exists("posix_getuid"))
	{
		$userinfo = posix_getpwuid(posix_getuid());
		$userhome = $userinfo["dir"];
	}
	else
	{
		$userhome = getenv("HOME");
	}

	return $userhome . "/";
}
function pts_current_user()
{
	// Current system user
	return ($pts_user = pts_read_user_config(P_OPTION_GLOBAL_USERNAME, "Default User")) != "Default User" ? $pts_user : phodevi::read_property("system", "username");
}
function pts_download_cache_user_directories()
{
	// Returns directory of the PTS Download Cache
	$dir_string = null;
	$cache_user_directories = array();

	if(($dir = getenv("PTS_DOWNLOAD_CACHE")) != false)
	{
		$dir_string .= $dir . ":";
	}

	$dir_string .= pts_read_user_config(P_OPTION_CACHE_DIRECTORY, "~/.phoronix-test-suite/download-cache/");

	foreach(array_map("trim", explode(":", $dir_string)) as $dir_check)
	{
		if($dir_check != null)
		{
			array_push($cache_user_directories, pts_add_trailing_slash(pts_find_home($dir_check)));
		}
	}

	return $cache_user_directories;
}

?>
