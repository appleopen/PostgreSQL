#!/usr/bin/ruby
#
# 99-postgres-cleanup.rb
#
# Author:: Apple Inc.
# Documentation:: Apple Inc.
# Copyright (c) 2013 Apple Inc. All Rights Reserved.
#
# IMPORTANT NOTE: This file is licensed only for use on Apple-branded
# computers and is subject to the terms and conditions of the Apple Software
# License Agreement accompanying the package this file is a part of.
# You may not port this file to another platform without Apple's written consent.
# License:: All rights reserved.
#

require 'fileutils'
require 'logger'

$logFile = "/Library/Logs/ServerSetup.log"
$logger = Logger.new($logFile)
$logger.level = Logger::INFO

pgForkedClustersDir = "/Library/Server/postgres_service_clusters"

if File.exists?(pgForkedClustersDir)
	if File.symlink?(pgForkedClustersDir)
		realPath = File.readlink(pgForkedClustersDir)
		d = Dir.new(realPath)
		if d.entries.count <= 2
			$logger.info("Forked cluster directory is now empty, removing it.")
			
			Dir.rmdir(realPath)
			File.unlink(pgForkedClustersDir)
		else
			$logger.info("Found forked cluster directory with service data that has not been cleaned up.")
		end
	else
		d = Dir.new(pgForkedClustersDir)
		if d.entries.count <= 2
			$logger.info("Forked cluster directory is now empty, removing it.")
		
			Dir.rmdir(pgForkedClustersDir)
		else
			$logger.info("Found forked cluster directory with service data that has not been cleaned up.")
		end
	end
end