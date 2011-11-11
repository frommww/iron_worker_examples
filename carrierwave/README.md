
### 1. Edit carrierwave.yml and fill in your SimpleWorker and AWS information.

Make sure that AWS S3 bucket exists.

### 2. Run "ruby carrierwave_worker_init.rb"

This will upload image to S3, so worker will have something to work with, and will create simple html page with link to uploaded image.

### 3. Lastly, run "ruby carrierwave_worker_runner.rb"

This will kick run your worker.  Once it has finished refresh the HTML page generated in step 1.
