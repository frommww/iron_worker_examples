
This is a sample worker that uses CarrierWave, RMagick, and ImageMagick to perform image manipulation using the [SimpleWorker service](http://www.simpleworker.com).


## 1. Edit carrierwave.yml and fill in your SimpleWorker and AWS information.

Make sure the bucket exists.  You can find your SimpleWorker project_id and token by logging into [SimpleWorker.com](http://www.simpleworker.com) and creating a new project.
The get started page will have your project_id and token.


## 2. Run "ruby carrierwave_worker_init.rb"

This will upload our sample image to S3 so that our sample worker will have an image to work with then it will create a simple html page with a link to the uploaded image in S3.

## 3. Lastly, run "ruby carrierwave_worker_runner.rb"

This is the exciting part!  Simply executing the runner will take the code in carrierwave_worker.rb, upload it to our servers and queue it in our system.  You can immediately
view the job running in your jobs tab at [SimpleWorker.com](http://www.simpleworker.com).  This particular sample should only take a few seconds to finish and then you can
refresh the HTML page created in step 2 viewing the image that was modified in your worker.
