/* eslint-disable */
import { useEffect, useState } from 'react';
import {
    Paper,
    Grid,
    Stack,
    Checkbox,
    Button,
    Backdrop,
    TextField,
    IconButton,
    Typography,
    FormControl,
    InputLabel,
    Input,
    InputAdornment,
    Stepper,
    Step,
    StepLabel,
    Box
} from '@mui/material';

function ResultForm({
    code, fullName, managementUnit, phone, address, gender, email, identityCard, image, username, password
}) {
    const [imgSrc, setImgSrc] = useState(null);
    useEffect(() => {
        let blobUrl = URL.createObjectURL(image);
        setImgSrc(blobUrl);
        return () => {
            URL.revokeObjectURL(blobUrl);
        }
    }, [image])


    return (
        <Box key='step-one' sx={{
            width: '100%',
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'top',
            padding: '0px 20px',
            color: '#000'
        }}>
            <Grid container spacing={2}>
                <Grid item xs={12} sm={6}>
                    <b>Mã nhân viên: </b> {code || 'Chưa có'}
                </Grid>
                <Grid item xs={12} sm={6}>
                    <b>Họ và tên: </b> {fullName || 'Chưa có'}
                </Grid>
                <Grid item xs={12} sm={6}>
                    <b>Phòng ban: </b> {managementUnit || 'Chưa có'}
                </Grid>
                <Grid item xs={12} sm={6}>
                    <b>Số điện thoại: </b> {phone || 'Chưa có'}
                </Grid>
                <Grid item xs={12} sm={6}>
                    <b>Địa chỉ: </b> {address || 'Chưa có'}
                </Grid>
                <Grid item xs={12} sm={6}>
                    <b>Email: </b> {email || 'Chưa có'}
                </Grid>
                <Grid item xs={12} sm={6}>
                    <b>CMND: </b> {identityCard || 'Chưa có'}
                </Grid>
                <Grid item xs={12} sm={6}>
                    <b>Giới tính: </b> {gender || 'Chưa có'}
                </Grid>
                <Grid item xs={12} sm={6}>
                    <b>Tên đăng nhập: </b> {username || 'Chưa có'}
                </Grid>
                <Grid item xs={12} sm={6}>
                    <b>Mật khẩu: </b> {password || 'Chưa có'}
                </Grid>
                <Grid item xs={12} sm={4}>
                    <b>Ảnh nhận diện: </b>
                </Grid>
                <Grid item xs={12} sm={8}>
                    <img src={imgSrc} alt="Ảnh chân dung" style={{ width: '200px', height: '200px', marginTop: '20px' }} />
                </Grid>
            </Grid>

        </Box>
    );
}

export default ResultForm;