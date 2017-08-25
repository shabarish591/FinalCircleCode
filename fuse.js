const {JSONPlugin, FuseBox} = require('fuse-box')

const fuse = ({ name }) => {
  let config = {
    cache: false,
    homeDir: `./`,
    output: `build/$name.js`,
    ignoreModules: ['aws-sdk'],
    globals: { 'lambda': '*' },
    package: {
      name: 'lambda',
      main: 'lambda.js'
    },
    plugins: [JSONPlugin()]
  }

  let fuseBox = FuseBox.init(config)
  fuseBox.bundle(name)
    .instructions(`>${name}.js`)
    .target('server')

  fuseBox.run()
}

fuse({ name: 'api-lambda' })
