package com.inhouse.rocking.aws.serverless.session02.model;


import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@RegisterForReflection
public class MyRequestPojo {
  String ssn;
  String name;
}
