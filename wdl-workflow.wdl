version 1.0

task WriteGreeting {
    # don't use tabs for indenting
    input {
        String name_for_greeting
    }
    command <<<
      echo 'hello ~{name_for_greeting}!' >greeting.txt
    >>>
    output {
        File greeting_output = "greeting.txt"
    }
    runtime {
        docker: ubuntu:latest
    }
}