This is a repository of sample workers to be used on [IronWorker](http://www.iron.io).

Feel free to copy, steal, take credit for, or whatever you feel like doing with this code. ;)

Most of these make use of the \_config.yml file for the IronWorker project_idtoken as well
as for the config keys and settings for the examples. Modify this file with your keys 
(or hardwire them into the example).

A few of the workers use other workers (master_slave example, for example). Make sure you
make use of the right path in the merge_worker. 

The same goes for any files that might be included with the worker. (You merge these with the
merge command).

For a Rails example, see: https://github.com/iron-io/iron_worker_rails_example
