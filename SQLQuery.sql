-- Cleaning Data

select *
from NashvilleHousing.dbo.NashvilleHousing

--Standarized Date format
select SaleDateConverted, CONVERT(Date, SaleDate) 
from NashvilleHousing.dbo.NashvilleHousing

update NashvilleHousing
set SaleDate = CONVERT(Date, SaleDate)

alter table NashvilleHousing
Add SaleDateConverted Date;


update NashvilleHousing
set SaleDateConverted = CONVERT(Date, SaleDate)


-- Poplulate Property Address Data
select *
from NashvilleHousing.dbo.NashvilleHousing
--where PropertyAddress is null
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing.dbo.NashvilleHousing a
join NashvilleHousing.dbo.NashvilleHousing b
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <>b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing.dbo.NashvilleHousing a
join NashvilleHousing.dbo.NashvilleHousing b
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <>b.[UniqueID ]
where a.PropertyAddress is null



-- Breaking out Address into Individual Columns (Address, City, State)
select PropertyAddress
from NashvilleHousing.dbo.NashvilleHousing

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) as Address
from NashvilleHousing.dbo.NashvilleHousing

alter table NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

update NashvilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 


alter table NashvilleHousing
Add PropertySplitCity Nvarchar(255);

update NashvilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))



select *
from NashvilleHousing.dbo.NashvilleHousing

Select OwnerAddress
from NashvilleHousing.dbo.NashvilleHousing
 
select 
PARSENAME(Replace(OwnerAddress,',','.'),3),
PARSENAME(Replace(OwnerAddress,',','.'),2),
PARSENAME(Replace(OwnerAddress,',','.'),1)
from NashvilleHousing.dbo.NashvilleHousing

alter table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

update NashvilleHousing
set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',','.'),3)


alter table NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

update NashvilleHousing
set OwnerSplitCity = PARSENAME(Replace(OwnerAddress,',','.'),2)

alter table NashvilleHousing
Add OwnerSplitState Nvarchar(255);

update NashvilleHousing
set OwnerSplitState = PARSENAME(Replace(OwnerAddress,',','.'),1)


select *
from NashvilleHousing.dbo.NashvilleHousing


--change Y and N to Yes and No in "Sold as Vacant" Field
select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from NashvilleHousing.dbo.NashvilleHousing
group by SoldAsVacant
order by 2


select SoldAsVacant,
case when SoldAsVacant = 'Y' then 'yes'
		when SoldAsVacant = 'N' then 'no'
		else SoldAsVacant
		end
from NashvilleHousing.dbo.NashvilleHousing

update NashvilleHousing
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'yes'
		when SoldAsVacant = 'N' then 'no'
		else SoldAsVacant
		end


-- Removing Duplicates
with RowNumCTE as(
select *,
ROW_NUMBER() over (
partition by ParcelID,
		PropertyAddress,
		SalePrice,
		SaleDate,
		LegalReference
		order by
		UniqueID
		) row_num
from NashvilleHousing.dbo.NashvilleHousing
)
--delete
--from RowNumCTE
--where row_num>1

select *
from RowNumCTE
where row_num>1
order by PropertyAddress



-- Deleting Unused Columns
select *
from NashvilleHousing.dbo.NashvilleHousing

alter table NashvilleHousing.dbo.NashvilleHousing
drop column OwnerAddress, TaxDistrict, PropertyAddress

alter table NashvilleHousing.dbo.NashvilleHousing
drop column saleDate

