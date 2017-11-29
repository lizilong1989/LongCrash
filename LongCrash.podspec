Pod::Spec.new do |spec|
  spec.name         = 'LongCrash'
  spec.version      = '1.0.0'
  spec.license       = { :type => 'Personal', :text => 'zilong.li' }
  spec.summary      = 'An Objective-C tool to avoid Crash'
  spec.homepage     = 'https://github.com/lizilong1989/LongCrash'
  spec.author       = {'zilong.li' => '15131968@qq.com'}
  spec.source       =  {:git => 'https://github.com/lizilong1989/LongCrash.git', :tag => spec.version.to_s }
  spec.platform     = :ios, '6.0'
  spec.requires_arc = true
  spec.xcconfig     = {'OTHER_LDFLAGS' => '-ObjC'}
  spec.default_subspec = 'Core'

  spec.subspec 'Core' do |core|
    core.source_files = 'src/**/*.{h,m,mm}'
    core.public_header_files = 'src/**/*.{h}'
  end
end
