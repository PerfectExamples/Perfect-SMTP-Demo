import PackageDescription

let package = Package(
    name: "Perfect-SMTP-Demo",
    dependencies: [.Package(url:"https://github.com/PerfectlySoft/Perfect-SMTP.git", majorVersion: 1, minor: 0)]
)
