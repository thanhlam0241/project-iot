/* eslint-disable */

import { useCallback, useState } from 'react';
import {
    Box,
    Button,
    Card,
    CardActions,
    CardContent,
    CardHeader,
    Divider,
    TextField,
    Unstable_Grid2 as Grid
} from '@mui/material';

export const CompanyInformation = () => {

    const [values, setValues] = useState({
        companyName: 'Công ty TNHH ABC',
        address: '123 Đường ABC, Quận 1, TP.HCM',
        taxCode: '1234567890',
        phone: '01234567891',
        representativeLegal: 'Bùi Trọng Đức',
    });


    const handleChange = useCallback(
        (event) => {
            setValues((prevState) => ({
                ...prevState,
                [event.target.name]: event.target.value
            }));
        },
        []
    );

    const handleSubmit = useCallback(
        (event) => {
            event.preventDefault();
        },
        []
    );

    return (
        <form
            autoComplete="off"
            noValidate
            onSubmit={handleSubmit}
        >
            <Card>
                <CardHeader
                    title="Thông tin chung"
                />
                <CardContent sx={{ padding: 0 }}>
                    <Box sx={{ width: '100%' }}>
                        <Grid
                            container
                            spacing={3}
                            sx={{ padding: 2, width: '100%' }}
                        >
                            <Grid
                                xs={10}
                                md={5}
                            >
                                <TextField
                                    fullWidth
                                    label="Tên công ty/doanh nghiệp"
                                    name="companyName"
                                    onChange={handleChange}
                                    required
                                    value={values.companyName}
                                />
                            </Grid>
                            <Grid
                                xs={10}
                                md={5}
                            >
                                <TextField
                                    fullWidth
                                    label="Địa chỉ"
                                    name="address"
                                    onChange={handleChange}
                                    required
                                    value={values.address}
                                />
                            </Grid>
                            <Grid
                                xs={10}
                                md={5}
                            >
                                <TextField
                                    fullWidth
                                    label="Mã số thuế"
                                    name="taxCode"
                                    onChange={handleChange}
                                    required
                                    value={values.taxCode}
                                />
                            </Grid>
                            <Grid
                                xs={10}
                                md={5}
                            >
                                <TextField
                                    fullWidth
                                    label="Số điện thoại liên hệ"
                                    name="phone"
                                    onChange={handleChange}
                                    type="number"
                                    value={values.phone}
                                />
                            </Grid>
                            <Grid
                                xs={10}
                                md={5}
                            >
                                <TextField
                                    fullWidth
                                    label="Đại diện pháp luật"
                                    name="representativeLegal"
                                    onChange={handleChange}
                                    required
                                    value={values.representativeLegal}
                                />
                            </Grid>
                        </Grid>
                    </Box>
                </CardContent>
                <Divider />
                <CardActions sx={{ justifyContent: 'flex-end' }}>
                    <Button variant="contained">
                        Lưu
                    </Button>
                </CardActions>
            </Card>
        </form>
    );
};