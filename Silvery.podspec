Pod::Spec.new do |s|
    s.name         = "Silvery"
    s.version      = "1.0.1"
    s.summary      = "Pure swift property introspection"
    s.description  = <<-DESC
                        Pure swift property introspection
                        DESC

    s.homepage     = "https://github.com/damouse/Silvery"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "Mickey Barboi" => "mickey.barboi@gmail.com" }
    s.source       = { :git => "https://github.com/damouse/Silvery.git", :tag => "1.0.1" }

    s.ios.deployment_target = "8.0"
    s.osx.deployment_target = "10.9"
    s.source_files  = "Silvery", "Silvery/**/*.{swift,h,m}"
    s.requires_arc = true
end
