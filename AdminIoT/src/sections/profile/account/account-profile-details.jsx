/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable perfectionist/sort-imports */
/* eslint-disable perfectionist/sort-named-imports */

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

import useAuth from 'src/hooks/Auth/auth';

// const states = [
//     {
//         value: 'alabama',
//         label: 'Alabama'
//     },
//     {
//         value: 'new-york',
//         label: 'New York'
//     },
//     {
//         value: 'san-francisco',
//         label: 'San Francisco'
//     },
//     {
//         value: 'los-angeles',
//         label: 'Los Angeles'
//     }
// ];

export const AccountProfileDetails = () => {

    const { auth } = useAuth();

    const [values, setValues] = useState({
        fullname: auth.fullname,
        email: auth.email,
        phone: auth.phone,
        identityCard: auth.identityCard,
        address: auth.address,
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
                    title="Thông tin"
                />
                <CardContent sx={{ pt: 0, margin: 1 }}>
                    <Box sx={{ m: -1.5 }}>
                        <Grid
                            container
                            spacing={3}
                        >
                            <Grid
                                xs={12}
                                md={6}
                            >
                                <TextField
                                    fullWidth
                                    label="Họ và tên"
                                    name="fullname"
                                    onChange={handleChange}
                                    required
                                    value={values.fullname}
                                />
                            </Grid>
                            <Grid
                                xs={12}
                                md={6}
                            >
                                <TextField
                                    fullWidth
                                    label="Số CCCD/CMND"
                                    name="lastName"
                                    onChange={handleChange}
                                    required
                                    value={values.identityCard}
                                />
                            </Grid>
                            <Grid
                                xs={12}
                                md={6}
                            >
                                <TextField
                                    fullWidth
                                    label="Địa chỉ email"
                                    name="email"
                                    onChange={handleChange}
                                    required
                                    value={values.email}
                                />
                            </Grid>
                            <Grid
                                xs={12}
                                md={6}
                            >
                                <TextField
                                    fullWidth
                                    label="Số điện thoại"
                                    name="phone"
                                    onChange={handleChange}
                                    type="number"
                                    value={values.phone}
                                />
                            </Grid>
                            <Grid
                                xs={12}
                                md={6}
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
                            {/* <Grid
                                xs={12}
                                md={6}
                            >
                                <TextField
                                    fullWidth
                                    label="Select State"
                                    name="state"
                                    onChange={handleChange}
                                    required
                                    select
                                    SelectProps={{ native: true }}
                                    value={values.state}
                                >
                                    {states.map((option) => (
                                        <option
                                            key={option.value}
                                            value={option.value}
                                        >
                                            {option.label}
                                        </option>
                                    ))}
                                </TextField>
                            </Grid> */}
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