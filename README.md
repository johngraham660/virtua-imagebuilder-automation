### Introduction
<I> Insert blurb here </I>

#### What's contained in the repo
* ```awscli_scripts``` script to manage the creation and deletion of Cloudformation Stacks
* ```buildcomponents``` Standalone build components for EC2ImageBuilder
* ```testcomponents``` Standalone test componments for EC2ImageBuilder
* ```cloudformation``` cloudformation templates that describe our EC2Imagebuilder resources
* ```buildspec``` Contains the build specification template for AWS CodeBuild and and scripts used in the build stage
* ```codebuild``` Contains the json object that describes the CodeBuild configuration and a build.sh script to deploy it via the awscli
* ```codepipeline``` Contains the json object that describes the CodePipeline configuration and a build.sh script to deploy it via the awscli

### Architecture

<I> Insert blurb here </I>   

### AWS CodeCommit
Our CodeCommit repository contains all of the Cloudformation templates required to deploy all of the EC2ImageBuilder resources which include :-

  * Infrastructure configurations
  * Distribution configurations
  * Build components
  * Test components
  * Image recipes
  * Image pipelines

### AWS CodeBuild
CodeBuild provides the Continous Integration component of our pipeline, it is responsible for pulling in our source code and performing the validation steps that are described in the buildspec files.

### AWS CodePipeline
In addition to CodeBuild, we are using CodePipeline to validates the CloudFormation templates and push them to our S3 bucket. The pipeline calls the corresponding CodeBuild project to validate each template, then deploys the validated CloudFormation templates to S3.
