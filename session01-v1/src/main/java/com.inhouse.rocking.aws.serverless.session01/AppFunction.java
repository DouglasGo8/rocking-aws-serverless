package com.inhouse.rocking.aws.serverless.session01;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.inhouse.rocking.aws.serverless.session01.model.MyRequestPojo;
import com.inhouse.rocking.aws.serverless.session01.model.MyResponsePojo;
import jakarta.inject.Named;

import java.time.LocalDateTime;

@Named("appFunction")
public class AppFunction implements RequestHandler<MyRequestPojo, MyResponsePojo> {
  @Override
  public MyResponsePojo handleRequest(MyRequestPojo myRequestPojo, Context context) {
    //
    var composedInfo = "Hello " + myRequestPojo.getName() + ": " + myRequestPojo.getSsn()
            + " at" + LocalDateTime.now();
    //
    return MyResponsePojo.builder()
            //.invokedFunctionArn(context.getInvokedFunctionArn())
            //.memoryLimitInMb(context.getMemoryLimitInMB())
            .finalMessage(composedInfo)
            .build();
  }
}
