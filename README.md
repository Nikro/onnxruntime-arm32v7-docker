# onnxruntime arm32v7 docker-cooker
A docker-cross-compilation-cooker for your arm32v7.

## Step 1.
Clone the repo: https://github.com/microsoft/onnxruntime - into a folder (i.e. /home/nikro/onnxruntime).

## Step 2.
Copy these files into the same folder.

## Step 3.
Run: `docker build -t onnx-arm32 .` - to build the image

## Step 4.
Once the image is built, run a container with that image. This will allow you to create an environment with the installed packages and built software:

```bash
docker run -it --name onnx-cook onnx-arm32 bash
```

This command starts a new container named onnx-cook from the onnx-arm32 image and opens a bash shell inside it.

## Step 5.
Now you are inside the container. You can find the built wheel file(s) in the /code directory (or wherever you set the working directory to be during the build). To list the wheel files, use:

```bash
ls /code/*.whl
```

## Step 6.
To copy the wheel file from the container to your host machine, you need to use the docker cp command. First, exit the container by typing exit or pressing Ctrl+D. Then, on your host machine, use the following command:

```bash
docker cp onnx-cook:/code/<your_wheel_file>.whl /path/to/destination/on/host/
```

Replace `<your_wheel_file>.whl` with the name of your wheel file and `/path/to/destination/on/host/` with the directory on your host machine where you want to copy the wheel file.

After executing this command, you will find the wheel file in the specified directory on your host machine. You can then install it using pip, share it, etc. Make sure to stop and remove the container after you're done to free up resources:

```bash
docker stop onnx-cook
docker rm onnx-cook
```
