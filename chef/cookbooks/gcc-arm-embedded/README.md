# gcc-arm-embedded Cookbook

Installs gcc-arm-embedded from a pre-built binary.  Puts the binary on the system and links it to the user's PATH.

## Requirements

### Platforms
- Debian/Ubuntu
- Mac OS X

Works on common Unix/Linux systems with typical userland utilities like tar, gzip, etc. May require the installation of build tools for compiling from source, but that installation is currently not supported by this cookbook.

### Chef
- Chef 12.0+

### Cookbooks
- apt -- needed for lib32c packages
- ark -- downloads and puts the binary, symlinks

## Attributes
Customize the attributes to suit site specific conventions and defaults.
- `node['gcc_arm']['dir']` - user to use for install.  defaults to /home/[user]/gcc-arm-embedded.
- `node['gcc_arm']['directories']['tmp']` - location of tmp folder to use for cookbook activities.


### gcc-arm-embedded::default

| Key | Type | Description | Default |
|-----|------|-------------|---------|
| <span style="font-family: monospace;">['gcc_arm']['user']</span> | String | User name used for install. The binary package will be given these user permissions and placed under this users home directory. | <span style="font-family: monospace;">vagrant</span> |
| <span style="font-family: monospace;">['gcc_arm']['group']</span> | String | Group to use for install. | <span style="font-family: monospace;">vagrant</span> |
| <span style="font-family: monospace;">['gcc_arm']['dir']</span> | String | Directory to place gcc_arm_embedded downloads/binaries/sources. | <span style="font-family: monospace;">/home/#{node['gcc_arm']['user']}/gcc-arm-embedded</span> |
| <span style="font-family: monospace;">['gcc_arm']['directories']['tmp']</span> | String | tmp folder for cookbook-related activities | <span style="font-family: monospace;">#{node['gcc_arm']['dir']}/bin</span> |

### gcc-arm-embedded::gcc_arm

| Key | Type | Description | Default |
|-----|------|-------------|---------|
| <span style="font-family: monospace;">['gcc_arm'][%platform_name%]['binary']</span> | Array | Array of hashes that define binary source url, checksum, and versions. | <span style="font-family: monospace;">none</span> |
| <span style="font-family: monospace;">['gcc_arm'][%platform_name%]['binary']['url']</span> | String | gcc-arm-embedded-EMBED binary download URL. | <span style="font-family: monospace;">https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2</span> |
| <span style="font-family: monospace;">['gcc_arm'][%platform_name%]['binary']['sha256_checksum']</span> | String | SHA-256 checksum of binary file. | <span style="font-family: monospace;">a397c49bdd0cf17a38a494cb691baf68b8dcffa4d4c06561ef3d71b2ab4c92a1</span> |
| <span style="font-family: monospace;">['gcc_arm'][%platform_name%]['binary']['version']</span> | String | User-defined version number. | <span style="font-family: monospace;">5.4.1</span> |
| <span style="font-family: monospace;">['gcc_arm'][%platform_name%]['binary']['binary_reported_version']</span> | String | Version number reported by binary (e.g. arm-none-eabi-gcc --version). | <span style="font-family: monospace;">5.4.1 20160919</span> |

### gcc-arm-embedded::gcc

| Key | Type | Description | Default |
|-----|------|-------------|---------|
| <span style="font-family: monospace;">['gcc_arm']['build-essential']['compile_time']</span> | Boolean | Attempt to obtain gcc before chef does anything. | <span style="font-family: monospace;">true</span> |

## Resources
Not currently defined.

## Actions
- `:create`: downloads the gcc-arm-embedded-embed binary and creates a 'friendly' symbolic link to the extracted directory path.


## Usage

### gcc-arm-embedded::default

Just include `gcc-arm-embedded` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[gcc-arm-embedded]"
  ]
}
```

## Examples

Install gcc-arm-embedded in non-default folder with non-default user.
```ruby
 gcc-arm-embedded do
   user 'my-user'
   group 'my-group'
   dir '/opt/gcc-arm-embedded'
   action :default
 end
```

Install gcc-arm-embedded in default folder for default user with non-default binary version.
```ruby
 gcc-arm-embedded do
   linux binary [
      {
         'url' => 'https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2',
         'sha256_checksum' => 'a397c49bdd0cf17a38a494cb691baf68b8dcffa4d4c06561ef3d71b2ab4c92a1',
         'version' => '5.4.1',
         'binary_reported_version' => '5.4.1 20160919'
      }
   ]
   action :default
 end
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License & Authors
- Author: Free Beachler, Longevity Software LLC, ([longevitysoft@gmail.com](mailto:longevitysoft@gmail.com))
- Copyright: 2016, Free Beachler

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

