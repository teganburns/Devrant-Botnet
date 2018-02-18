# Devrant-Botnet

Notes for video and bash script for creating bots on devrant.com

# DISCLAIMER

**ANY CODE THAT IS A PART OF THIS REPOSITORY IS NOT TO BE USED IN ANY WAY THAT VIOLATES THE "devRant Terms of Service". REFRENCE TO THIS DOCUMENT CAN BE FOUND ON [devRant Terms of Service](https://devrant.com/terms)**





# Prerequisites

- bash 
- [jq]( https://stedolan.github.io/jq/ )
- [curl]( https://curl.haxx.se/ )
- [PhantomJS](http://phantomjs.org/)
- [dialog](https://invisible-island.net/dialog/)

Both **jq** and **curl** should be avaiable in most Linux distribution's package repository. 

## Account Creation Requirements
- Your username must be between 4 and 15 characters.
- Your password must be at least 6 characters.


### Form Data

**app**
- Default value for 3rd party clients use the backend code 3.

**type**
- Default value was 1. Can't say for sure what this represents.

**email**
- The email that you're signing up with.

**username**
- The username that you're signing up with.

**password**
- The password that you're signing up with.

**guid**
- Tracking id. ( example: y1tuxw18-133a-4m6w-mu1u-4m9zsekr7guc )

**plat**
- Default value for 3rd party clients use the backend code 3.

**sid**
- Tracking id. ( example: 1512511036000 )

**seid**
- Another tracking id. 


| Key name | Required |
| ---      | ---      |
| app      | Y        |
| type     | Y        |
| email    | Y        |
| username | Y        |
| password | Y        |
| plat     | N        |
| sid      | N        |
| seid     | N        |

## Response Data

```
{
    "success": true,
    "auth_token": {
        "id": 1057183,
        "key": "GiV15j3U2d2WZgCj6vbWiTefkbqNAhJ9_oHSH5sN",
        "expire_time": 1515174688,
        "user_id": 1057182
    }
}
```


