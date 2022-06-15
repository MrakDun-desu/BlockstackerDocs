To use a custom skin, you'll need to create a directory `styleCustomization/skins` in the application persistent data path. This directory can also be created and opened from the in-game customization settings.

## Creating a custom skin

1. Think up your own skin name and create a directory named after it in the `skins` directory.
2. Create the skin files as explained [here](#supported-skin-formats)
3. Put your skin files in your skin directory and name them accordingly. Naming conventions are explained [here](#naming-conventions).
4. Pick your skin in the game customization settings and wait for it to load.

## Loading a premade skin

1. Copy the skin source directory into the `skins` directory.
2. Pick your skin in the game customization settings and wait for it to load.

## Supported skin formats
BlockStacker-desu currently supports the same formats as [Tetr.io plus](https://gitlab.com/UniQMG/tetrio-plus/-/wikis/custom-skins) with exceptions of GIF and SVG formats. The used skin format is determined by [naming](#naming-conventions) and by the image dimensions.

In case the skin file is 128x128px, it is assumed that file is a Tetr.io 6.10 ghost.<br/>
In case the skin file is 256x256px, it is assumed that file is a Tetr.io 6.10 skin.<br/>
In case the skin file is 512x512px, it is assumed that file is a Tetr.io 6.10 connected ghost.<br/>
In case the skin file is 1024x1024px, it is assumed that file is a Tetr.io 6.10 connected skin.<br/>
These skin formats have a block size of 46x46px with 1px of padding on each side, so 48x48px.

In other cases, the skin loader tries to detect skin format by the aspect ratio.<br/>
In case the aspect ratio is 9/1, it is assumed that file is a Jstris skin.<br/>
Block size in this format is same as the skin height, with no gaps.

In case the aspect ratio is 12.4/1, it is assumed that file is an old Tetr.io skin.<br/>
Block size in this format is the same as skin height. The skin has gaps of 1px on the right side of each block.

In case the aspect ratio is 9/20, it is assumed that file is a Jstris connected skin.<br/>
Block size in this format is determined by width/9, with no gaps.

All skins can be either still or animated. If the skin is animated, it will be identified by all the skin files ending with numbers starting with 0, representing the animation sequence.

### Examples
Tetr.io 6.10 ghost:

![ghost](https://user-images.githubusercontent.com/39689572/173831685-06f0c13f-eb97-4479-80dd-a24290078da5.png)

Tetr.io 6.10 skin: 

![skin](https://user-images.githubusercontent.com/39689572/173831480-d55a0e04-3767-4399-92b9-0fdcb769c927.png)

Tetr.io 6.10 connected ghost:

![Connected ghost](https://user-images.githubusercontent.com/39689572/173834549-c70ecd39-a4cc-43a7-8f7b-86cdbff4dc7b.png)

Tetr.io 6.10 connected skin:

![Connected skin](https://user-images.githubusercontent.com/39689572/173832471-640cb751-40e7-4ebd-91c3-6cee1aa21141.png)

Tetr.io old skin:

![tetrio](https://user-images.githubusercontent.com/39689572/173828901-a0f5d377-1319-4faf-abb4-5e8ad00bc354.png)

Jstris skin:

![jstris](https://user-images.githubusercontent.com/39689572/173830251-a9a4aefa-65f1-412a-a528-9f7468393d13.png)

Jstris connected skin:

![jstris connected](https://user-images.githubusercontent.com/39689572/173830359-aad61350-94cb-40ac-825b-9b847ac352ab.png)


## Naming conventions
Skin files should be named either just `skin` or exactly the same as skin name (excluding extension).

In case of Tetr.io 6.10 skin formats, ghost skin files should have suffix `ghost`.

In case of animated skins, all skin files should end with numbers, starting with 0.

## Supported file types

Supported file types are only `.jpg`, `.jpeg` and `.png` so far. Any other files won't be loaded.