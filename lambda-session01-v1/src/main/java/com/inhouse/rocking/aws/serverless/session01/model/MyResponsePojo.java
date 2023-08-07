package com.inhouse.rocking.aws.serverless.session01.model;

import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.*;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@RegisterForReflection
public class MyResponsePojo {
  String finalMessage;
}
