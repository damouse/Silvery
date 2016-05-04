Pod::Spec.new do |s|
    s.name         = "Silvery"
    s.version      = "1.0.0"
    s.summary      = "Key-Value Coding (KVC) for native Swift classes and structs"
    s.description  = <<-DESC
                        Silvery enables Key-Value Coding (KVC) for native Swift classes and structs.
                        DESC
    s.homepage     = "https://github.com/bradhilton/Silvery"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "Brad Hilton" => "brad@skyvive.com" }
    s.source       = { :git => "https://github.com/bradhilton/Silvery.git", :tag => "1.0.0" }
    s.ios.deployment_target = "8.0"
    s.osx.deployment_target = "10.9"
    s.source_files  = "Silvery", "Silvery/**/*.{swift,h,m}"
    s.requires_arc = true
end
