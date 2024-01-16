import torch
import os
import numpy as np

from utils import get_device
from models import get_facenet, get_mtcnn
from typing import List
from config import *
from PIL import Image


class Model:
    def __init__(self):
        self.device = get_device()
        self.facenet = get_facenet()
        self.mtcnn = get_mtcnn()


    def register(
        self,
        userid: str,
        prob_threshold: float = DETECTION_THRESHOLD
    ) -> bool:
        """
        Save the embedding tensor and threshold value for userid

        Parameters
        ----------
        image_path : str
            Path to the image file

        userid : str
            User ID

        prob_threshold : float, optional
            Probability threshold for face detection, by default 0.99

        Returns
        -------
        bool
            Whether the user is registered or not
        """
        # Check the parameters
        images = self.process_image(
            save=True,
            prob_threshold=prob_threshold
        )

        if len(images) == 0:
            print("No faces found !!!")
            return False

        # Check if the app_data/database/userid folder exists
        if not os.path.exists(f"app_data/database/{userid}"):
            os.makedirs(f"app_data/database/{userid}")

        # compute the mean of the images in the cropped folder
        images = torch.stack(images).float().to(self.device)
        embeddings, _ = self.facenet(images)
        embeddings = embeddings.detach().cpu()

        # Save the embeddings
        torch.save(embeddings, f"app_data/database/{userid}/embeddings.pt")

        # Free the memory
        del images, embeddings
        torch.cuda.empty_cache()

        print("User registered successfully")
        return True
    

    def identification(
        self,
        prob_threshold: float = DETECTION_THRESHOLD,
        threshold: float = VERIFICATION_THRESHOLD
    ):
        """
        Identifies the person in the images

        Parameters
        ----------
        path : str
            Path to the image file

        prob_threshold : float, optional
            Probability threshold for face detection

        threshold : float, optional
            Threshold value for cosine similarity

        Returns
        -------
        str
            User ID of the person in the images
        """

        user_list = os.listdir("app_data/database")
        user_similarity = dict()

        # Get the images
        images = self.process_image(
            prob_threshold=prob_threshold,
            save=True
        )

        if len(images) == 0:
            print("No faces found in the images")
            return None

        # Get the embeddings of the images
        images = torch.stack(images).float().to(self.device)
        images_embeddings, _ = self.facenet(images)
        images_embeddings = images_embeddings.detach().cpu()

        # Iterate over all the users
        for user in user_list:
            # Read user's embeddings
            user_embeddings = torch.load(f"app_data/database/{user}/embeddings.pt")

            # Compute the cosine similarity between all pairs of images and user's embeddings
            # Matrix multiplication of images_embeddings and user_embeddings
            similarity = torch.mm(images_embeddings, user_embeddings.t()).mean().item()

            if similarity >= threshold:
                user_similarity[user] = similarity

        if len(user_similarity) == 0:
            print("No user found")
            return ""
        
        # Get the user with the highest similarity
        user = max(user_similarity, key=user_similarity.get)
        print(f"User {user} identified successfully with similarity {user_similarity[user]}")
        torch.cuda.empty_cache()
        return user
    

    def process_image(
        self,
        path: str = "app_data/temp/picture",
        save: bool = False,
        prob_threshold: float = DETECTION_THRESHOLD
    ) -> List[torch.Tensor]:
        """
        Processes the image and saves the frames in the app_data/temp/picture folder
        Crop faces from the frames and save them in the app_data/temp/cropped folder

        Parameters
        ----------
        path : str
            Path to the image file

        save : bool, optional
            Whether to save the frames or not, by default False

        prob_threshold : float, optional
            Probability threshold for face detection

        Returns
        -------
        List[torch.Tensor]
            List of images. Each image is a tensor of shape (160, 160, 3)

        """
        images_list = []

        for file in os.listdir(path):
            if file.endswith(".jpg") or file.endswith(".png") or file.endswith(".jfif"):
                # Read the image
                image = Image.open(os.path.join(path, file))

                # Crop the faces from the frames
                x_aligned, prob = self.mtcnn(image, return_prob=True)
                if prob is not None:
                    if prob > prob_threshold:
                        # Add the image to the list
                        images_list.append(x_aligned)
                        if save:
                            # Convert from tensor to PIL image and save
                            x_aligned = x_aligned.permute(1, 2, 0).to('cpu').numpy()
                            x_aligned = x_aligned * 128 + 127.5
                            x_aligned = x_aligned.astype(np.uint8)
                            x_aligned = Image.fromarray(x_aligned)

                            # Save the cropped image
                            x_aligned.save(f'app_data/temp/cropped/{file}')

        return images_list