package com.inhouse.rocking.aws.serverless.session02;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.S3Event;
import jakarta.inject.Named;
import org.jboss.logging.Logger;


@Named("appFunction")
public class AppFunction implements RequestHandler<S3Event, String> {

  private static final Logger log = Logger.getLogger(AppFunction.class);

  @Override
  public String handleRequest(S3Event s3Event, Context context) {

    var s3Info = s3Event.getRecords().getFirst().getS3();
    //
    var bucketKey = s3Info.getObject().getKey();
    var bucketName = s3Info.getBucket().getName();

    log.info("BUCKET NAME: " + bucketName + " BUCKET KEY: " + bucketKey);

    return "Content-Type: APPLICATION/TEXT";
  }
}
