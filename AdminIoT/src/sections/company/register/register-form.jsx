/* eslint-disable  */

import { useState } from 'react';
import PropsType from 'prop-types';
import './register.css';

import {
    Grid,
    Button,
    Backdrop,
    TextField,
    Typography,
    Stepper,
    Step,
    StepLabel,
    Box
}
    from '@mui/material';

import ResultForm from './result-form';

const steps = ['Điền thông tin cá nhân', 'Đăng ký nhận dạng khuôn mặt', 'Hoàn tất']

import SelectVariants from 'src/components/select/select-varient';
import Capture from './webcam';

import adminApi from 'src/api/adminApi';

export default function Form({ open, handleClose, listUnit, message }) {
    const [activeStep, setActiveStep] = useState(0)
    const [skipped, setSkipped] = useState(new Set())

    const [imgBlobs, setImgBlobs] = useState([])
    const [disableFinishBtn, setDisableFinishBtn] = useState(false)

    const [code, setCode] = useState('120322432')
    const [fullName, setFullName] = useState('Hello World')
    const [identityCard, setIdentityCard] = useState('123')
    const [phone, setPhone] = useState('12344')
    const [address, setAddress] = useState('1234')
    const [email, setEmail] = useState('1234')
    const [genger, setGenger] = useState('')
    const [department, setDepartment] = useState('')

    const [username, setUsername] = useState('user10000')
    const [password, setPassword] = useState('123456')

    const changeState = {
        changeCode: (e) => {
            setCode(e.target.value)
        },
        changeFullName: (e) => {
            setFullName(e.target.value)
        },
        changeIdentityCard: (e) => {
            setIdentityCard(e.target.value)
        },
        changePhone: (e) => {
            setPhone(e.target.value)
        },
        changeAddress: (e) => {
            setAddress(e.target.value)
        },
        changeEmail: (e) => {
            setEmail(e.target.value)
        },
        changeGenger: (valuee) => {
            setGenger(valuee)
        },
        changeDepartment: (valuee) => {
            setDepartment(valuee)
        },
        changeUsername: (e) => {
            setUsername(e.target.value)
        },
        changePassword: (e) => {
            setPassword(e.target.value)
        },
    }

    const isStepOptional = (step) => {
        return false
    }

    const isStepSkipped = (step) => {
        return skipped.has(step)
    }

    const handleFinish = async () => {
        var formdata = new FormData();
        for (let i = 0; i < imgBlobs.length; i++) {
            formdata.append("images", imgBlobs[i], `${i + 1}.jfif`);
        }

        const data = {
            username: username,
            password: password,
            code: code,
            fullName: fullName,
            identityCard: identityCard,
            phone: phone,
            address: address,
            email: email,
            gender: genger === 1 ? 'MALE' : 'FEMALE',
            role: 'EMPLOYEE',
            active: true,
            managementUnitId: department,
        }

        formdata.append("model", JSON.stringify(data));

        console.log(formdata)

        await adminApi.registerFace(formdata);
    }

    const handleNext = () => {
        if (activeStep === 0) {
            const data = {
                code,
                fullName,
                identityCard,
                phone,
                address,
                email,
                genger,
                department,
                username,
                password,
            }
            console.log(data)
        }
        else if (activeStep === 2) {
            setDisableFinishBtn(true);
            handleFinish().then(() => { setDisableFinishBtn(false); });
        }
        let newSkipped = skipped
        if (isStepSkipped(activeStep)) {
            newSkipped = new Set(newSkipped.values())
            newSkipped.delete(activeStep)
        }

        setActiveStep((prevActiveStep) => prevActiveStep + 1)
        setSkipped(newSkipped)
    }

    const handleBack = () => {
        setActiveStep((prevActiveStep) => prevActiveStep - 1)
    }

    const handleSkip = () => {
        if (!isStepOptional(activeStep)) {
            // You probably want to guard against something like this,
            // it should never occur unless someone's actively trying to break something.
            throw new Error("You can't skip a step that isn't optional.")
        }

        setActiveStep((prevActiveStep) => prevActiveStep + 1)
        setSkipped((prevSkipped) => {
            const newSkipped = new Set(prevSkipped.values())
            newSkipped.add(activeStep)
            return newSkipped
        })
    }

    const handleReset = () => {
        setUsername('')
        setPassword('')
        setCode('')
        setFullName('')
        setIdentityCard('')
        setPhone('')
        setAddress('')
        setEmail('')
        setGenger('')
        setDepartment('')
        setImgBlobs([])
        setActiveStep(0)
    }

    const handleCaptureFace = (data) => {
        if (data && data.length === 30) {
            setImgBlobs(data);
            handleNext();
        }
        else {
            alert('Please check your face.')
        }
    }


    return (
        <Backdrop
            sx={{ color: '#fff', zIndex: (theme) => theme.zIndex.drawer + 1 }}
            open={open}
        >
            <div className='register-form'>
                <Stepper activeStep={activeStep}>
                    {steps.map((label, index) => {
                        const stepProps = {}
                        const labelProps = {}
                        if (isStepOptional(index)) {
                            labelProps.optional = <Typography variant='caption'>Optional</Typography>
                        }
                        if (isStepSkipped(index)) {
                            stepProps.completed = false
                        }
                        return (
                            <Step key={label} {...stepProps}>
                                <StepLabel {...labelProps}>{label}</StepLabel>
                            </Step>
                        )
                    })}
                </Stepper>
                {activeStep === steps.length ? (
                    <>
                        <Box sx={{ display: 'flex', flexDirection: 'row', pt: 2, color: '#000' }}>
                            <Box sx={{ flex: '1 1 auto' }} />
                            {/* <Button onClick={handleReset}>Reset</Button> */}
                            <p>{message}</p>
                        </Box>
                    </>
                ) : (
                    <>
                        <Box sx={{ display: 'flex', flexDirection: 'row', pt: 2 }}>
                            <Button variant='contained' disabled={activeStep === 0} onClick={handleBack} sx={{ mr: 1 }}>
                                Trở lại
                            </Button>
                            <Box sx={{ flex: '1 1 auto' }} />
                            {isStepOptional(activeStep) && (
                                <Button variant='outlined' onClick={handleSkip} sx={{ mr: 1 }}>
                                    Skip
                                </Button>
                            )}
                            <Button disabled={disableFinishBtn} onClick={handleNext}>{activeStep === steps.length - 1 ? 'Hoàn tất' : 'Tiếp'}</Button>
                        </Box>
                        {activeStep === 0 && (
                            <Box key='step-one' sx={{ width: '100%', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                                <Grid container spacing={2}>
                                    <Grid item xs={12} sm={6}>
                                        <TextField
                                            required
                                            id="employeeCode"
                                            name="employeeCode"
                                            label="Mã nhân viên"
                                            fullWidth
                                            variant="standard"
                                            value={code}
                                            onChange={changeState.changeCode}
                                        />
                                    </Grid>
                                    <Grid item xs={12} sm={6}>
                                        <TextField
                                            required
                                            id="fullName"
                                            name="fullName"
                                            label="Tên nhân viên"
                                            fullWidth
                                            variant="standard"
                                            value={fullName}
                                            onChange={changeState.changeFullName}
                                        />
                                    </Grid>
                                    <Grid item xs={12} sm={6}>
                                        <TextField
                                            required
                                            id="identityCard"
                                            name="identityCard"
                                            label="CCCD/CMND"
                                            fullWidth
                                            variant="standard"
                                            value={identityCard}
                                            onChange={changeState.changeIdentityCard}
                                        />
                                    </Grid>
                                    <Grid item xs={12} sm={6}>
                                        <TextField
                                            required
                                            id="phone"
                                            name="phone"
                                            label="Số điện thoại"
                                            fullWidth
                                            variant="standard"
                                            value={phone}
                                            onChange={changeState.changePhone}
                                        />
                                    </Grid>
                                    <Grid item xs={12} sm={6}>
                                        <TextField
                                            id="address"
                                            name="address"
                                            label="Địa chỉ"
                                            fullWidth
                                            variant="standard"
                                            value={address}
                                            onChange={changeState.changeAddress}
                                        />
                                    </Grid>
                                    <Grid item xs={12} sm={6}>
                                        <TextField
                                            id="email"
                                            name="email"
                                            label="Email"
                                            fullWidth
                                            variant="standard"
                                            value={email}
                                            onChange={changeState.changeEmail}
                                        />
                                    </Grid>
                                    <Grid item xs={12} sm={6}>
                                        <SelectVariants
                                            options={[
                                                { id: 1, value: 1, name: 'Nam' },
                                                { id: 2, value: 2, name: 'Nữ' }
                                            ]}
                                            label="Giới tính"
                                            fullWidth
                                            variant="standard"
                                            onChange={changeState.changeGenger}
                                            value={genger}
                                        />
                                    </Grid>
                                    <Grid item xs={12} sm={6}>
                                        <SelectVariants
                                            options={listUnit.map(
                                                (item) => ({ id: item.id, value: item.id, name: item.name })
                                            )}
                                            label="Đơn vị/Phòng ban"
                                            fullWidth
                                            variant="standard"
                                            onChange={changeState.changeDepartment}
                                            value={department}
                                        />
                                    </Grid>
                                    <Grid item xs={12} sm={6}>
                                        <TextField
                                            required
                                            id="username"
                                            name="username"
                                            label="Tên đăng nhập"
                                            fullWidth
                                            variant="standard"
                                            onChange={changeState.changeUsername}
                                            value={username}
                                        />
                                    </Grid>
                                    <Grid item xs={12} sm={6}>
                                        <TextField
                                            required
                                            id="password"
                                            name="password"
                                            label="Mật khẩu"
                                            fullWidth
                                            variant="standard"
                                            onChange={changeState.changePassword}
                                            value={password}
                                        />
                                    </Grid>
                                </Grid>
                            </Box>
                        )}
                        {activeStep === 1 && <Capture width={300} onCaptured={handleCaptureFace} />}
                        {activeStep === 2 && (
                            <ResultForm
                                code={code}
                                fullName={fullName}
                                identityCard={identityCard}
                                phone={phone}
                                address={address}
                                email={email}
                                genger={genger}
                                department={department}
                                username={username}
                                password={password}
                                image={imgBlobs.length > 0 ? imgBlobs[0] : ''}
                            />
                        )}
                    </>
                )}
                <div className='header-register-form'>
                    <Button color="error" variant='contained' onClick={handleReset}>
                        Reset
                    </Button>
                    <Button color="error" variant='outlined' onClick={handleClose}>
                        Đóng
                    </Button>
                </div>
            </div>
        </Backdrop>
    );
}

Form.propTypes = {
    open: PropsType.bool,
    handleClose: PropsType.func,
};