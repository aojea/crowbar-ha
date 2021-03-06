#
# Cookbook Name:: drbd
# Recipe:: install
#
# Copyright 2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

node[:drbd][:packages].each do |pkg|
  package pkg do
    action :install
  end
end

ruby_block "load drbd module" do
  block do
    %x[ modprobe drbd ]
    raise "problem with loading drbd module" unless $?.exitstatus == 0
  end
  not_if { ::File.exists?("/sys/module/drbd") }
end
