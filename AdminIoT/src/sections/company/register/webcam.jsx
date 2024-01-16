/* eslint-disable */

import Webcam from 'react-webcam'
import { useRef, useState, useCallback } from 'react'
import './Capture.css'
import { Button } from '@mui/material'

const videoConstraints = {
    facingMode: {
        exact: 'user'
    }
}
const Capture = ({ onCaptured, width, height }) => {
    const webcamRef = useRef(null)
    // const captureBtnRef = useRef<any>(null)
    const [btnDisabled, setBtnDisabled] = useState(false);
    const [progress, setProgress] = useState(0);

    const capturePhoto = useCallback(async () => {
        if (webcamRef.current) {
            setBtnDisabled(true);
            let imageCount = 0;
            let cam = webcamRef.current;
            // let formdata = new FormData();
            let imgBlobs = []
            let timeId = setInterval(async () => {
                const imageSrc = cam.getScreenshot();
                if (imageSrc) {
                    imageCount++;
                    setProgress(imageCount);
                    let blob = await fetch(imageSrc).then(r => r.blob());
                    imgBlobs.push(blob);
                    // formdata.append("images", blob, `${imageCount}.jfif`)
                    if (imageCount == 30) {
                        clearInterval(timeId);

                        let promise = onCaptured?.(imgBlobs);

                        if (promise instanceof Promise) {
                            await promise;
                        }

                        setBtnDisabled(false);
                    }
                }
            }, 200);

        }
    }, [webcamRef, onCaptured, setBtnDisabled, setProgress])

    const onUserMedia = (stream) => {
        // mediaStreamRef.current = stream;
    }
    let _videoConstraints = videoConstraints;
    if (width) {
        _videoConstraints.width = width;
    }
    if (height) {
        _videoConstraints.height = height;
    }
    return (
        <div className='capture-container'>
            <Webcam
                ref={webcamRef}
                audio={false}
                imageSmoothing={true}
                screenshotFormat='image/jpeg'
                videoConstraints={_videoConstraints}
                width={600}
                height={320}
                onUserMedia={onUserMedia}
            />
            <div className='capture-frame-box-progress'
                style={{ visibility: (btnDisabled ? "visible" : "collapse"), width: (10 * progress) }}></div>
            <div className='detect-face'></div>
            <Button className="capture-button"
                variant='contained'
                onClick={capturePhoto}
                disabled={btnDisabled}
            >
                Check
            </Button>
        </div>
    )
}

export default Capture