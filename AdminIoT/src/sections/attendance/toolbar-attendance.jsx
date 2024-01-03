import PropTypes from 'prop-types';

import Stack from '@mui/material/Stack';
import Tooltip from '@mui/material/Tooltip';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import OutlinedInput from '@mui/material/OutlinedInput';
import InputAdornment from '@mui/material/InputAdornment';

import Iconify from 'src/components/iconify';
import BasicSelect from 'src/components/select/select-basic';

// ----------------------------------------------------------------------

export default function TableToolbar({
    filterName,
    onFilterName,
    onOpenFilter,
    changeYear,
    changeMonth,
    defaultValueMonth,
    defaultValueYear
}) {
    const onChangeMonth = (value) => {
        console.log(value)
        changeMonth(value)
    }
    const onChangeYear = (value) => {
        console.log(value)
        changeYear(value)
    }
    const handleFilterName = (event) => {
        onFilterName(event.target.value);
    }
    return (
        <Toolbar
            sx={{
                height: 66,
                display: 'flex',
                justifyContent: 'space-between',
                p: 0,
                mb: '5px'
            }}
        >
            <Stack direction="row" alignItems="center" justifyContent="flex-start" gap={2} >
                <OutlinedInput
                    value={filterName}
                    onChange={handleFilterName}
                    placeholder="Tìm kiếm"
                    startAdornment={
                        <InputAdornment position="start">
                            <Iconify
                                icon="eva:search-fill"
                                sx={{ color: 'text.disabled', width: 20, height: 20 }}
                            />
                        </InputAdornment>
                    }
                />
                <BasicSelect
                    label="Năm"
                    required
                    value={defaultValueYear}
                    onChange={onChangeYear}
                    options={[
                        { id: 4, name: '2024', value: '2024' },
                        { id: 3, name: '2023', value: '2023' },
                        { id: 2, name: '2022', value: '2022' },
                        { id: 1, name: '2021', value: '2021' },
                    ]}
                />
                <BasicSelect
                    label="Tháng"
                    value={defaultValueMonth}
                    onChange={onChangeMonth}
                    options={[
                        { id: 1, name: '1', value: '1' },
                        { id: 2, name: '2', value: '2' },
                        { id: 3, name: '3', value: '3' },
                        { id: 4, name: '4', value: '4' },
                        { id: 5, name: '5', value: '5' },
                        { id: 6, name: '6', value: '6' },
                        { id: 7, name: '7', value: '7' },
                        { id: 8, name: '8', value: '8' },
                        { id: 9, name: '9', value: '9' },
                        { id: 10, name: '10', value: '10' },
                        { id: 11, name: '11', value: '11' },
                        { id: 12, name: '12', value: '12' },
                    ]}
                />
            </Stack>

            <Tooltip title="Filter list">
                <IconButton onClick={onOpenFilter}>
                    <Iconify icon="ic:round-filter-list" />
                </IconButton>
            </Tooltip>

        </Toolbar >
    );
}

TableToolbar.propTypes = {
    filterName: PropTypes.string,
    onFilterName: PropTypes.func,
    onOpenFilter: PropTypes.func,
    changeYear: PropTypes.func,
    changeMonth: PropTypes.func,
    defaultValueMonth: PropTypes.string,
    defaultValueYear: PropTypes.string
};
