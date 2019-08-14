
echo "Downloading weightsfile.."
wget -O weights/yolo-obj_last.weights https://pjreddie.com/media/files/darknet53.conv.74 

echo "Start training docker.."
docker run --rm -it\
   -v $(PWD)/results:/project/backup \
   -v $(PWD)/weights/yolo-obj_last.weights:/project/weights/yolo.weights \
   -v $(PWD)/cfg/yolo-obj.cfg:/project/cfg/yolo.cfg \
   -v $(PWD)/data_vedai_pict:/project/data \
   darknet:latest

